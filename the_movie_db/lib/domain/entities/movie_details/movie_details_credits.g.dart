// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_credits.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsCredits _$MovieDetailsCreditsFromJson(Map<String, dynamic> json) =>
    MovieDetailsCredits(
      cast: (json['cast'] as List<dynamic>)
          .map((e) => Cast.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as List<dynamic>)
          .map((e) => Crew.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieDetailsCreditsToJson(
        MovieDetailsCredits instance) =>
    <String, dynamic>{
      'cast': instance.cast.map((e) => e.toJson()).toList(),
      'crew': instance.crew.map((e) => e.toJson()).toList(),
    };

Crew _$CrewFromJson(Map<String, dynamic> json) => Crew(
      adult: json['adult'] as bool? ?? true,
      gender: (json['gender'] as num?)?.toInt() ?? 0,
      id: (json['id'] as num?)?.toInt() ?? 0,
      knownForDepartment: json['known_for_department'] as String,
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      profilePath: json['profile_path'] as String?,
      creditId: json['credit_id'] as String,
      department: json['department'] as String,
      job: json['job'] as String,
    );

Map<String, dynamic> _$CrewToJson(Crew instance) => <String, dynamic>{
      'adult': instance.adult,
      'gender': instance.gender,
      'id': instance.id,
      'known_for_department': instance.knownForDepartment,
      'name': instance.name,
      'original_name': instance.originalName,
      'popularity': instance.popularity,
      'profile_path': instance.profilePath,
      'credit_id': instance.creditId,
      'department': instance.department,
      'job': instance.job,
    };

Cast _$CastFromJson(Map<String, dynamic> json) => Cast(
      adult: json['adult'] as bool? ?? true,
      gender: (json['gender'] as num?)?.toInt() ?? 0,
      id: (json['id'] as num?)?.toInt() ?? 0,
      knownForDepartment: json['known_for_department'] as String,
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      profilePath: json['profile_path'] as String?,
      castId: (json['cast_id'] as num?)?.toInt() ?? 0,
      character: json['character'] as String,
      creditId: json['credit_id'] as String,
      order: (json['order'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CastToJson(Cast instance) => <String, dynamic>{
      'adult': instance.adult,
      'gender': instance.gender,
      'id': instance.id,
      'known_for_department': instance.knownForDepartment,
      'name': instance.name,
      'original_name': instance.originalName,
      'popularity': instance.popularity,
      'profile_path': instance.profilePath,
      'cast_id': instance.castId,
      'character': instance.character,
      'credit_id': instance.creditId,
      'order': instance.order,
    };
