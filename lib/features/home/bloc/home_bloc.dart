import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/di.dart';
import '../data/data.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.seriesRepository) : super(HomeInitial()) {
    on<HomeLoad>(_homeLoad);
  }

  final SeriesRepositoryInterface seriesRepository;

  Future<void> _homeLoad(HomeLoad event, Emitter<HomeState> emit) async {
    try {
      if (state is! HomeLoadSuccess) {
        emit(HomeLoadInProgress());
      }
      final series = await seriesRepository.getSeries();
      emit(HomeLoadSuccess(series: series));
    } catch (exception, state) {
      emit(HomeLoadFailure(exception: exception));
      talker.handle(exception, state);
    } finally {
      event.completer?.complete();
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    talker.handle(error, stackTrace);
  }
}
