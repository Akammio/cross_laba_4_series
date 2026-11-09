import '../models/series.dart';

abstract interface class SeriesRepositoryInterface {
  Future<List<Series>> getSeries();

  Future<Series> getSeriesById(int id);
}
