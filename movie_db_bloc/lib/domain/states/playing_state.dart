// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:the_movie_db/constants/region_enum.dart';
import 'package:the_movie_db/domain/server_entities/movies/movies.dart';
import 'package:the_movie_db/domain/server_entities/movies/popular_movie_response.dart';

class PlayingListsState {
  PlayingListsState({
    required this.playingMovies,
    required this.playingShows,
    required this.selectedRegion,
    required this.errorMessage,
  });

  PlayingListsState.init()
      : playingMovies = PopularMovieResponse.init(),
        playingShows = PopularMovieResponse.init(),
        selectedRegion = RegionType.ru.name,
        errorMessage = '';

  final PopularMovieResponse playingMovies;
  List<Movie> get movies => playingMovies.movies;
  final PopularMovieResponse playingShows;
  List<Movie> get shows => playingShows.movies;
  final String selectedRegion;
  final String errorMessage;

  PlayingListsState copyWith({
    PopularMovieResponse? playingMovies,
    PopularMovieResponse? playingShows,
    String? selectedRegion,
    String? errorMessage,
  }) {
    return PlayingListsState(
      playingMovies: playingMovies ?? this.playingMovies,
      playingShows: playingShows ?? this.playingShows,
      selectedRegion: selectedRegion ?? this.selectedRegion,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(covariant PlayingListsState other) {
    if (identical(this, other)) {
      return true;
    }

    return other.playingMovies == playingMovies &&
        other.playingShows == playingShows &&
        other.selectedRegion == selectedRegion &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode {
    return playingMovies.hashCode ^
        playingShows.hashCode ^
        selectedRegion.hashCode ^
        errorMessage.hashCode;
  }
}
