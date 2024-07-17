import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_db/domain/entities/date_parser/date_parser.dart';
import 'package:the_movie_db/domain/entities/general/genre.dart';
import 'package:the_movie_db/domain/entities/general/productionCountry.dart';
import 'package:the_movie_db/domain/entities/movie_details/movie_details_credits.dart';
import 'package:the_movie_db/domain/entities/movie_details/movie_details_video.dart';

part 'show_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ShowDetails {
  const ShowDetails({
    this.adult = true,
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    this.id = 0,
    this.inProduction = true,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    required this.nextEpisodeToAir,
    required this.networks,
    this.numberOfEpisodes = 0,
    this.numberOfSeasons = 0,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    this.popularity = 0,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
    required this.credits,
    required this.videos,
  });

  factory ShowDetails.fromJson(Map<String, dynamic> json) =>
      _$ShowDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ShowDetailsToJson(this);

  final bool? adult;
  final String? backdropPath;
  final List<CreatedBy> createdBy;
  final List<int> episodeRunTime;

  @JsonKey(fromJson: parseDateFromString)
  final DateTime? firstAirDate;

  final List<Genre> genres;
  final String? homepage;
  final int id;
  final bool inProduction;
  final List<String>? languages;

  @JsonKey(fromJson: parseDateFromString)
  final DateTime? lastAirDate;

  final LastEpisodeToAir? lastEpisodeToAir;
  final String name;
  final LastEpisodeToAir? nextEpisodeToAir;
  final List<Networks>? networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String originalName;
  final String? overview;
  final double popularity;
  final String? posterPath;
  final List<Networks>? productionCompanies;
  final List<ProductionCountry> productionCountries;
  final List<Seasons>? seasons;
  final List<ShowSpokenLanguages>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;
  final MovieDetailsCredits credits;
  final MovieDetailsVideo videos;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ShowSpokenLanguages {
  const ShowSpokenLanguages({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  factory ShowSpokenLanguages.fromJson(Map<String, dynamic> json) =>
      _$ShowSpokenLanguagesFromJson(json);

  Map<String, dynamic> toJson() => _$ShowSpokenLanguagesToJson(this);

  final String? englishName;

  @JsonKey(name: 'iso_639_1')
  final String? iso6391;

  final String? name;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Seasons {
  const Seasons({
    required this.airDate,
    this.episodeCount = 0,
    this.id = 0,
    required this.name,
    required this.overview,
    required this.posterPath,
    this.seasonNumber = 0,
    this.voteAverage = 0,
  });

  factory Seasons.fromJson(Map<String, dynamic> json) =>
      _$SeasonsFromJson(json);

  Map<String, dynamic> toJson() => _$SeasonsToJson(this);

  @JsonKey(fromJson: parseDateFromString)
  final DateTime? airDate;

  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int? seasonNumber;
  final int? voteAverage;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Networks {
  const Networks({
    this.id = 0,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory Networks.fromJson(Map<String, dynamic> json) =>
      _$NetworksFromJson(json);

  Map<String, dynamic> toJson() => _$NetworksToJson(this);

  final int id;
  final String? logoPath;
  final String? name;
  final String? originCountry;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LastEpisodeToAir {
  const LastEpisodeToAir({
    this.id = 0,
    required this.name,
    required this.overview,
    this.voteAverage = 0,
    this.voteCount = 0,
    required this.airDate,
    this.episodeNumber = 0,
    required this.episodeType,
    this.productionCode = '',
    this.runtime = 0,
    this.seasonNumber = 0,
    this.showId = 0,
    required this.stillPath,
  });

  factory LastEpisodeToAir.fromJson(Map<String, dynamic> json) =>
      _$LastEpisodeToAirFromJson(json);

  Map<String, dynamic> toJson() => _$LastEpisodeToAirToJson(this);

  final int id;
  final String? name;
  final String? overview;
  final double voteAverage;
  final int voteCount;

  @JsonKey(fromJson: parseDateFromString)
  final DateTime? airDate;

  final int episodeNumber;
  final String episodeType;
  final String productionCode;
  final int runtime;
  final int seasonNumber;
  final int showId;
  final String? stillPath;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CreatedBy {
  const CreatedBy({
    this.id = 0,
    required this.creditId,
    required this.name,
    required this.originalName,
    this.gender = 0,
    required this.profilePath,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) =>
      _$CreatedByFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedByToJson(this);

  final int id;
  final String? creditId;
  final String? name;
  final String? originalName;
  final int gender;
  final String? profilePath;
}
