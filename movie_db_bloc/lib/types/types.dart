import 'package:flutter/foundation.dart';
import 'package:the_movie_db/domain/server_entities/movie_details/movie_details_credits.dart';
import 'package:the_movie_db/domain/server_entities/movies/movies.dart';
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
    this.voteAverage = 0.0,
  });

  final int id;
  final String? title;
  final String? name;
  final String? posterPath;
  final String? releaseDate;
  final String? firstAirDate;
  final String? overview;
  final String mediaType;
  final double voteAverage;
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

class MoviesContainer {
  MoviesContainer({
    required this.movies,
    required this.currentPage,
    required this.totalPages,
  });

  const MoviesContainer.init()
      : movies = const <Movie>[],
        currentPage = 0,
        totalPages = 1;

  final List<Movie> movies;
  final int currentPage;
  final int totalPages;

  bool get isComplete => currentPage >= totalPages;

  MoviesContainer copyWith({
    List<Movie>? movies,
    int? currentPage,
    int? totalPages,
  }) {
    return MoviesContainer(
      movies: movies ?? this.movies,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  String toString() =>
      'MoviesContainer(movies: $movies, currentPage: $currentPage, totalPages: $totalPages)';

  @override
  bool operator ==(covariant MoviesContainer other) {
    if (identical(this, other)) {
      return true;
    }

    return listEquals(other.movies, movies) &&
        other.currentPage == currentPage &&
        other.totalPages == totalPages;
  }

  @override
  int get hashCode =>
      movies.hashCode ^ currentPage.hashCode ^ totalPages.hashCode;
}
