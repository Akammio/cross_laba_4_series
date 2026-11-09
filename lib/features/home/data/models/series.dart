import 'package:json_annotation/json_annotation.dart';

part 'series.g.dart';

String _genresFromJson(List<dynamic>? genres) =>
    genres?.map((e) => e['name']?.toString() ?? '').join(', ') ?? '';

String? _imageFromJson(Map<String, dynamic>? poster) =>
    poster?['previewUrl'] as String?;

@JsonSerializable()
class Series {
  const Series({
    required this.id,
    required this.title,
    required this.description,
    this.image,
    this.year,
    this.genre = '',
    this.seasons,
  });

  @JsonKey(name: 'id')
  final int id;

  // defaultValue — если 'name' нет (бывает!), подставим заглушку
  @JsonKey(name: 'name', defaultValue: 'Без названия')
  final String title;

  // defaultValue — у многих сериалов description отсутствует
  @JsonKey(name: 'description', defaultValue: '')
  final String description;

  @JsonKey(name: 'poster', fromJson: _imageFromJson)
  final String? image;

  @JsonKey(name: 'year')
  final int? year;

  // defaultValue тоже важен — у некоторых нет жанров
  @JsonKey(name: 'genres', fromJson: _genresFromJson, defaultValue: '')
  final String genre;

  final int? seasons;

  factory Series.fromJson(Map<String, dynamic> json) => _$SeriesFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesToJson(this);
}