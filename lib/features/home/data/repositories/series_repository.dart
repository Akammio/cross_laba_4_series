import 'package:dio/dio.dart';

import '../../../../data/dio/endpoints.dart';
import '../models/series.dart';
import 'series_repository_interface.dart';

class SeriesRepository implements SeriesRepositoryInterface {
  SeriesRepository({required this.dio});

  final Dio dio;

  @override
  Future<List<Series>> getSeries() async {
    try {
      final Response response = await dio.get(
        Endpoints.films,
        queryParameters: {
          'page': 1, 
          'limit': 20,
          'type': 'tv-series',
        },
      );
      
      final items = response.data['docs'] as List<dynamic>;
      
      final series = items
          .where((e) => e['poster'] != null) // <-- ФИЛЬТР: берем только тех, у кого есть постер
          .map((e) => Series.fromJson(e as Map<String, dynamic>))
          .toList();
          
      return series;
    } on DioException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Future<Series> getSeriesById(int id) async {
    try {
      final Response response = await dio.get(
        '${Endpoints.films}/$id',
      );
      return Series.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw e.message.toString();
    }
  }
}