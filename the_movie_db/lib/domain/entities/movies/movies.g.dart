// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      posterPath: json['poster_path'] as String?,
      adult: json['adult'] as bool? ?? true,
      overview: json['overview'] as String,
      releaseDate: parseDateFromString(json['release_date'] as String?),
      firstAirDate: parseDateFromString(json['first_air_date'] as String?),
      genreIds: (json['genre_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      id: (json['id'] as num?)?.toInt() ?? 0,
      originalTitle: json['original_title'] as String?,
      originalLanguage: json['original_language'] as String?,
      title: json['title'] as String?,
      name: json['name'] as String?,
      originalName: json['original_name'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0,
      voteCount: (json['vote_count'] as num?)?.toInt() ?? 0,
      video: json['video'] as bool? ?? true,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0,
      mediaType: json['media_type'] as String?,
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'poster_path': instance.posterPath,
      'adult': instance.adult,
      'overview': instance.overview,
      'release_date': instance.releaseDate?.toIso8601String(),
      'first_air_date': instance.firstAirDate?.toIso8601String(),
      'genre_ids': instance.genreIds,
      'id': instance.id,
      'original_title': instance.originalTitle,
      'original_language': instance.originalLanguage,
      'original_name': instance.originalName,
      'title': instance.title,
      'name': instance.name,
      'backdrop_path': instance.backdropPath,
      'popularity': instance.popularity,
      'vote_count': instance.voteCount,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'media_type': instance.mediaType,
    };
