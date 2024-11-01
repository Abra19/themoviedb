// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:the_movie_db/constants/region_enum.dart';
import 'package:the_movie_db/domain/server_entities/movies/movies.dart';
import 'package:the_movie_db/domain/server_entities/movies/popular_movie_response.dart';

class NewMoviesListsState {
  NewMoviesListsState({
    required this.newMovies,
    required this.newShows,
    required this.selectedRegion,
    required this.errorMessage,
  });

  NewMoviesListsState.init()
      : newMovies = PopularMovieResponse.init(),
        newShows = PopularMovieResponse.init(),
        selectedRegion = RegionType.ru.name,
        errorMessage = '';

  final PopularMovieResponse newMovies;
  List<Movie> get movies => newMovies.movies;
  final PopularMovieResponse newShows;
  List<Movie> get shows => newShows.movies;
  final String selectedRegion;
  final String errorMessage;

  NewMoviesListsState copyWith({
    PopularMovieResponse? newMovies,
    PopularMovieResponse? newShows,
    String? selectedRegion,
    String? errorMessage,
  }) {
    return NewMoviesListsState(
      newMovies: newMovies ?? this.newMovies,
      newShows: newShows ?? this.newShows,
      selectedRegion: selectedRegion ?? this.selectedRegion,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(covariant NewMoviesListsState other) {
    if (identical(this, other)) {
      return true;
    }

    return other.newMovies == newMovies &&
        other.newShows == newShows &&
        other.selectedRegion == selectedRegion &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode {
    return newMovies.hashCode ^
        newShows.hashCode ^
        selectedRegion.hashCode ^
        errorMessage.hashCode;
  }
}
