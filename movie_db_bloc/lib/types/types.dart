import 'package:the_movie_db/domain/server_entities/movie_details/movie_details_credits.dart';
import 'package:the_movie_db/domain/server_entities/show_details/show_details.dart';

class DataStructure {
  DataStructure({
    required this.id,
    required this.posterPath,
    required this.title,
    required this.percent,
    required this.date,
    required this.type,
  });

  final int id;
  final String? posterPath;
  final String? title;
  final double percent;
  final String date;
  final String? type;
}

class MovieListRowData {
  MovieListRowData({
    required this.id,
    required this.title,
    required this.name,
    required this.posterPath,
    required this.releaseDate,
    required this.firstAirDate,
    required this.overview,
    required this.mediaType,
  });

  final int id;
  final String? title;
  final String? name;
  final String? posterPath;
  final String? releaseDate;
  final String? firstAirDate;
  final String? overview;
  final String mediaType;
}

class MovieDetailsData {
  bool isLoading = true;
  String title = 'Loading ...';
  String overview = '';
  String? backdropPath;
  String? posterPath;
  String releaseYear = '';
  String releaseDate = '';
  String genres = '';
  String countries = '';
  double voteAverage = 0;
  String runtime = '';
  List<CrewData> crew = <CrewData>[];
  List<Cast> cast = <Cast>[];
}

class ShowDetailsData {
  bool isLoading = true;
  String name = 'Loading ...';
  String overview = '';
  String? backdropPath;
  String? posterPath;
  String releaseYear = '';
  String releaseDate = '';
  String genres = '';
  String countries = '';
  double voteAverage = 0;
  String runtime = '';
  List<CrewData> crew = <CrewData>[];
  List<Cast> cast = <Cast>[];
  int numberOfSeasons = 0;
  int numberOfEpisodes = 0;
  String tagline = '';
  bool inProduction = false;
  LastEpisodeToAir? lastEpisodeToAir;
}

class ActorDatas {
  bool isLoading = true;
  String name = 'Loading...';
  String? profilePath;
  String birthday = '';
  String deathday = '';
  String biography = '';
  String placeOfBirth = '';
}
