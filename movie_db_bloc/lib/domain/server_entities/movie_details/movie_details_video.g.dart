// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsVideo _$MovieDetailsVideoFromJson(Map<String, dynamic> json) =>
    MovieDetailsVideo(
      results: (json['results'] as List<dynamic>?)
          ?.map(
              (e) => MovieDetailVideoResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieDetailsVideoToJson(MovieDetailsVideo instance) =>
    <String, dynamic>{
      'results': instance.results?.map((e) => e.toJson()).toList(),
    };

MovieDetailVideoResult _$MovieDetailVideoResultFromJson(
        Map<String, dynamic> json) =>
    MovieDetailVideoResult(
      iso6391: json['iso_639_1'] as String?,
      iso31661: json['iso_3166_1'] as String?,
      name: json['name'] as String?,
      key: json['key'] as String?,
      site: json['site'] as String?,
      size: (json['size'] as num?)?.toInt() ?? 0,
      type: json['type'] as String?,
      official: json['official'] as bool? ?? true,
      publishedAt: json['published_at'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$MovieDetailVideoResultToJson(
        MovieDetailVideoResult instance) =>
    <String, dynamic>{
      'iso_639_1': instance.iso6391,
      'iso_3166_1': instance.iso31661,
      'name': instance.name,
      'key': instance.key,
      'site': instance.site,
      'size': instance.size,
      'type': instance.type,
      'official': instance.official,
      'published_at': instance.publishedAt,
      'id': instance.id,
    };
