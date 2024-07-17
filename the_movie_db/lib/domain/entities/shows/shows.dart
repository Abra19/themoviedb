import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_db/domain/entities/date_parser/date_parser.dart';

part 'shows.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TVShow {
  const TVShow({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    this.id = 0,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    this.popularity = 0,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    this.voteAverage = 0,
    this.voteCount = 0,
  });

  factory TVShow.fromJson(Map<String, dynamic> json) => _$TVShowFromJson(json);
  Map<String, dynamic> toJson() => _$TVShowToJson(this);

  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;

  @JsonKey(fromJson: parseDateFromString)
  final DateTime? firstAirDate;

  final String name;
  final double voteAverage;
  final int voteCount;
}
