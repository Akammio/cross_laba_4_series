import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../di/di.dart';
import '../../../widgets/content_card.dart';
import 'bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _home = getIt<HomeBloc>();

  void loadHome() => _home.add(HomeLoad());

  Future<void> _onRefresh() {
    final completer = Completer<void>();
    _home.add(HomeLoad(completer: completer));
    return completer.future;
  }

  @override
  void initState() {
    loadHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Сериалы'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: _home,
        builder: (context, state) {
          return switch (state) {
            HomeInitial() => const SizedBox.shrink(),
            HomeLoadInProgress() => const Center(
                child: CircularProgressIndicator(),
              ),
            HomeLoadSuccess() => RefreshIndicator(
                onRefresh: _onRefresh,
                child: _buildHomeLoadSuccess(state),
              ),
            HomeLoadFailure() => _buildHomeLoadFailure(state),
          };
        },
      ),
    );
  }

  Widget _buildHomeLoadSuccess(HomeLoadSuccess state) {
    final series = state.series;
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: series.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final item = series[index];
        return ContentCard(
          id: item.id,
          title: item.title,
          description: item.description,
          image: item.image,
          onTap: () => context.push('/content/${item.id}'),
        );
      },
    );
  }

  Widget _buildHomeLoadFailure(HomeLoadFailure state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Ошибка загрузки: ${state.exception}'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: loadHome,
            child: const Text('Повторить'),
          ),
        ],
      ),
    );
  }
}
