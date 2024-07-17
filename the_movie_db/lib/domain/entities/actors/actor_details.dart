import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_db/domain/entities/date_parser/date_parser.dart';

part 'actor_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ActorDetails {
  const ActorDetails({
    this.adult = true,
    required this.alsoKnownAs,
    required this.biography,
    required this.birthday,
    required this.deathday,
    this.gender = 0,
    required this.homepage,
    this.id = 0,
    required this.imdbId,
    required this.knownForDepartment,
    required this.name,
    required this.placeOfBirth,
    this.popularity = 0.0,
    required this.profilePath,
  });

  factory ActorDetails.fromJson(Map<String, dynamic> json) =>
      _$ActorDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ActorDetailsToJson(this);

  final bool adult;
  final List<String>? alsoKnownAs;
  final String? biography;

  @JsonKey(fromJson: parseDateFromString)
  final DateTime? birthday;

  @JsonKey(fromJson: parseDateFromString)
  final DateTime? deathday;

  final int gender;
  final String? homepage;
  final int id;
  final String? imdbId;
  final String? knownForDepartment;
  final String? name;
  final String? placeOfBirth;
  final double popularity;
  final String? profilePath;

  @override
  String toString() {
    return 'ActorDetails(name: $name, biography: $biography';
  }
}
