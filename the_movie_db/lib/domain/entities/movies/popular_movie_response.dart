import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_db/domain/entities/movies/movies.dart';

part 'popular_movie_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PopularMovieResponse {
  PopularMovieResponse({
    this.page = 0,
    required this.movies,
    this.totalPages = 0,
    this.totalResults = 0,
  });

  factory PopularMovieResponse.fromJson(Map<String, dynamic> json) =>
      _$PopularMovieResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PopularMovieResponseToJson(this);

  final int page;

  @JsonKey(name: 'results')
  final List<Movie>? movies;

  final int totalPages;
  final int totalResults;
}
