import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_db/domain/server_entities/date_parser/date_parser.dart';

part 'movies.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Movie {
  Movie({
    required this.posterPath,
    this.adult = true,
    required this.overview,
    this.releaseDate,
    this.firstAirDate,
    required this.genreIds,
    this.id = 0,
    this.originalTitle,
    required this.originalLanguage,
    this.title,
    this.name,
    this.originalName,
    required this.backdropPath,
    this.popularity = 0,
    this.voteCount = 0,
    this.video = true,
    this.voteAverage = 0,
    this.mediaType = '',
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);

  final String? posterPath;
  final bool adult;
  final String? overview;

  @JsonKey(fromJson: parseDateFromString)
  final DateTime? releaseDate;

  @JsonKey(fromJson: parseDateFromString)
  final DateTime? firstAirDate;

  final List<int> genreIds;
  final int id;
  final String? originalTitle;
  final String? originalLanguage;
  final String? originalName;
  final String? title;
  final String? name;
  final String? backdropPath;
  final double popularity;
  final int voteCount;
  final bool video;
  final double voteAverage;
  String mediaType;
}
