// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actor_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActorDetails _$ActorDetailsFromJson(Map<String, dynamic> json) => ActorDetails(
      adult: json['adult'] as bool? ?? true,
      alsoKnownAs: (json['also_known_as'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      biography: json['biography'] as String?,
      birthday: parseDateFromString(json['birthday'] as String?),
      deathday: parseDateFromString(json['deathday'] as String?),
      gender: (json['gender'] as num?)?.toInt() ?? 0,
      homepage: json['homepage'] as String?,
      id: (json['id'] as num?)?.toInt() ?? 0,
      imdbId: json['imdb_id'] as String?,
      knownForDepartment: json['known_for_department'] as String?,
      name: json['name'] as String?,
      placeOfBirth: json['place_of_birth'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      profilePath: json['profile_path'] as String?,
    );

Map<String, dynamic> _$ActorDetailsToJson(ActorDetails instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'also_known_as': instance.alsoKnownAs,
      'biography': instance.biography,
      'birthday': instance.birthday?.toIso8601String(),
      'deathday': instance.deathday?.toIso8601String(),
      'gender': instance.gender,
      'homepage': instance.homepage,
      'id': instance.id,
      'imdb_id': instance.imdbId,
      'known_for_department': instance.knownForDepartment,
      'name': instance.name,
      'place_of_birth': instance.placeOfBirth,
      'popularity': instance.popularity,
      'profile_path': instance.profilePath,
    };
