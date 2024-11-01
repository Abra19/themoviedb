// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:the_movie_db/constants/period_enum.dart';
import 'package:the_movie_db/domain/server_entities/movies/movies.dart';
import 'package:the_movie_db/domain/server_entities/movies/popular_movie_response.dart';

class TrendedListsState {
  TrendedListsState({
    required this.trendedMovies,
    required this.selectedPeriod,
    required this.errorMessage,
  });

  TrendedListsState.init()
      : trendedMovies = PopularMovieResponse.init(),
        selectedPeriod = PeriodType.day.name,
        errorMessage = '';

  final PopularMovieResponse trendedMovies;
  List<Movie> get movies => trendedMovies.movies;
  final String selectedPeriod;
  final String errorMessage;

  TrendedListsState copyWith({
    PopularMovieResponse? trendedMovies,
    String? selectedPeriod,
    String? errorMessage,
  }) {
    return TrendedListsState(
      trendedMovies: trendedMovies ?? this.trendedMovies,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(covariant TrendedListsState other) {
    if (identical(this, other)) return true;

    return other.trendedMovies == trendedMovies &&
        other.selectedPeriod == selectedPeriod &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      trendedMovies.hashCode ^ selectedPeriod.hashCode ^ errorMessage.hashCode;
}
