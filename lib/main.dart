import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'di/di.dart';
import 'features/home/home.dart';
import 'features/content/content_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/content/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return ContentScreen(contentId: id);
          },
        ),
      ],
    );

    return MaterialApp.router(
      title: 'Сериалы',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
    );
  }
}