// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_shows_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularTVShowsResponse _$PopularTVShowsResponseFromJson(
        Map<String, dynamic> json) =>
    PopularTVShowsResponse(
      page: (json['page'] as num?)?.toInt() ?? 0,
      shows: (json['results'] as List<dynamic>?)
          ?.map((e) => TVShow.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: (json['total_pages'] as num?)?.toInt() ?? 0,
      totalResults: (json['total_results'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PopularTVShowsResponseToJson(
        PopularTVShowsResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.shows?.map((e) => e.toJson()).toList(),
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
