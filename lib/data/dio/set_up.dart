import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import '../../di/di.dart';

void setUpDio() {
  dio.options.baseUrl = 'https://api.poiskkino.dev/v1.4';
  dio.options.connectTimeout = const Duration(seconds: 10);
  dio.options.receiveTimeout = const Duration(seconds: 10);
  
  // Вставляем ваш токен
  dio.options.headers.addAll({
    'X-API-KEY': 'RK8PH9E-YV543HD-NC895R6-32ZX9PK',
    'Content-Type': 'application/json',
  });

  dio.interceptors.addAll([
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printRequestData: true,
        printRequestHeaders: true,
      ),
    ),
  ]);
}