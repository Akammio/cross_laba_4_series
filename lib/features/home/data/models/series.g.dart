// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Series _$SeriesFromJson(Map<String, dynamic> json) => Series(
  id: (json['id'] as num).toInt(),
  title: json['name'] as String? ?? 'Без названия',
  description: json['description'] as String? ?? '',
  image: _imageFromJson(json['poster'] as Map<String, dynamic>?),
  year: (json['year'] as num?)?.toInt(),
  genre: json['genres'] == null ? '' : _genresFromJson(json['genres'] as List?),
  seasons: (json['seasons'] as num?)?.toInt(),
);

Map<String, dynamic> _$SeriesToJson(Series instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.title,
  'description': instance.description,
  'poster': instance.image,
  'year': instance.year,
  'genres': instance.genre,
  'seasons': instance.seasons,
};
