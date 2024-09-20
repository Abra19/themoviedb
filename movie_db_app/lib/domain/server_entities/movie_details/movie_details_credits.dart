import 'package:json_annotation/json_annotation.dart';

part 'movie_details_credits.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDetailsCredits {
  const MovieDetailsCredits({
    required this.cast,
    required this.crew,
  });

  factory MovieDetailsCredits.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsCreditsFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsCreditsToJson(this);

  final List<Cast> cast;
  final List<Crew> crew;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Crew {
  const Crew({
    this.adult = true,
    this.gender = 0,
    this.id = 0,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    this.popularity = 0.0,
    required this.profilePath,
    required this.creditId,
    required this.department,
    required this.job,
  });

  factory Crew.fromJson(Map<String, dynamic> json) => _$CrewFromJson(json);

  Map<String, dynamic> toJson() => _$CrewToJson(this);

  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final String creditId;
  final String department;
  final String job;
}

class CrewData {
  CrewData({required this.name, required this.job});

  final String name;
  final String job;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Cast {
  const Cast({
    this.adult = true,
    this.gender = 0,
    this.id = 0,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    this.popularity = 0.0,
    required this.profilePath,
    this.castId = 0,
    required this.character,
    required this.creditId,
    this.order = 0,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);

  Map<String, dynamic> toJson() => _$CastToJson(this);

  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final int castId;
  final String character;
  final String creditId;
  final int order;
}
