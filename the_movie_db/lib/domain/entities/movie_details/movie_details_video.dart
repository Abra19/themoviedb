import 'package:json_annotation/json_annotation.dart';

part 'movie_details_video.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDetailsVideo {
  const MovieDetailsVideo({
    required this.results,
  });

  factory MovieDetailsVideo.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsVideoFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsVideoToJson(this);

  final List<MovieDetailVideoResult>? results;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieDetailVideoResult {
  const MovieDetailVideoResult({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    this.size = 0,
    required this.type,
    this.official = true,
    required this.publishedAt,
    required this.id,
  });

  factory MovieDetailVideoResult.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailVideoResultFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailVideoResultToJson(this);

  @JsonKey(name: 'iso_639_1')
  final String? iso6391;

  @JsonKey(name: 'iso_3166_1')
  final String? iso31661;

  final String? name;
  final String? key;
  final String? site;
  final int size;
  final String? type;
  final bool official;
  final String? publishedAt;
  final String? id;

  @override
  String toString() {
    return 'key: $key, id: $id';
  }
}
