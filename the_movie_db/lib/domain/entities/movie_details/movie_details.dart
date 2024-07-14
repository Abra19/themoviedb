import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_db/domain/entities/date_parser/movie_date_parser.dart';
import 'package:the_movie_db/domain/entities/movie_details/movie_details_credits.dart';
import 'package:the_movie_db/domain/entities/movie_details/movie_details_video.dart';

part 'movie_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDetails {
  MovieDetails({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.credits,
    required this.videos,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsToJson(this);

  final bool adult;
  final String? backdropPath;
  final BelongsToCollection? belongsToCollection;
  final int budget;
  final List<Genre> genres;
  final String? homepage;
  final int id;
  final String? imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String? overview;
  final double popularity;
  final String? posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final MovieDetailsCredits credits;
  final MovieDetailsVideo videos;

  @JsonKey(fromJson: parseDateFromString)
  final DateTime? releaseDate;

  final int revenue;
  final int? runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String? tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SpokenLanguage {
  SpokenLanguage({
    required this.iso,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguageFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguageToJson(this);

  @JsonKey(name: 'iso_639_1')
  final String iso;
  final String name;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCountry {
  ProductionCountry({
    required this.iso,
    required this.name,
  });

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountryToJson(this);

  @JsonKey(name: 'iso_3166_1')
  final String iso;
  final String name;

  @override
  String toString() {
    return iso;
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCompany {
  ProductionCompany({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompanyToJson(this);

  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Genre {
  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  Map<String, dynamic> toJson() => _$GenreToJson(this);

  final int id;
  final String name;

  @override
  String toString() {
    return name;
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class BelongsToCollection {
  const BelongsToCollection();

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) =>
      _$BelongsToCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$BelongsToCollectionToJson(this);
}
