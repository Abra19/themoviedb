import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_db/domain/entities/shows/shows.dart';

part 'popular_shows_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PopularTVShowsResponse {
  PopularTVShowsResponse({
    this.page = 0,
    required this.shows,
    this.totalPages = 0,
    this.totalResults = 0,
  });

  factory PopularTVShowsResponse.fromJson(Map<String, dynamic> json) =>
      _$PopularTVShowsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PopularTVShowsResponseToJson(this);

  final int page;

  @JsonKey(name: 'results')
  final List<TVShow>? shows;
  final int totalPages;
  final int totalResults;
}
