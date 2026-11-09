import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../data/data.dart';
import '../features/home/bloc/home_bloc.dart';
import '../features/home/data/repositories/series_repository.dart';
import '../features/home/data/repositories/series_repository_interface.dart';

final getIt = GetIt.instance;
final talker = TalkerFlutter.init();
final Dio dio = Dio();

Future<void> setupLocator() async {
  setUpDio();

  getIt.registerSingleton<SeriesRepositoryInterface>(
    SeriesRepository(dio: dio),
  );

  getIt.registerSingleton(
    HomeBloc(getIt.get<SeriesRepositoryInterface>()),
  );

  Bloc.observer = TalkerBlocObserver(talker: talker);
}
