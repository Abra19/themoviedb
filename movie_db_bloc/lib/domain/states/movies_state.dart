// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:the_movie_db/domain/server_entities/movies/movies.dart';

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

class MoviesListState {
  MoviesListState({
    required this.popularMoviesContainer,
    required this.searchMoviesContainer,
    required this.searchQuery,
    required this.errorMessage,
  });

  MoviesListState.init()
      : popularMoviesContainer = const MoviesContainer.init(),
        searchMoviesContainer = const MoviesContainer.init(),
        searchQuery = '',
        errorMessage = null;

  final MoviesContainer popularMoviesContainer;
  final MoviesContainer searchMoviesContainer;
  final String searchQuery;
  String? errorMessage;

  bool get isSearchMode => searchQuery.isNotEmpty;

  List<Movie> get movies => isSearchMode
      ? searchMoviesContainer.movies
      : popularMoviesContainer.movies;

  MoviesListState copyWith({
    MoviesContainer? popularMoviesContainer,
    MoviesContainer? searchMoviesContainer,
    String? searchQuery,
    String? errorMessage,
  }) {
    return MoviesListState(
      popularMoviesContainer:
          popularMoviesContainer ?? this.popularMoviesContainer,
      searchMoviesContainer:
          searchMoviesContainer ?? this.searchMoviesContainer,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() =>
      'MoviesListState(popularMoviesContainer: $popularMoviesContainer, searchMoviesContainer: $searchMoviesContainer, searchQuery: $searchQuery)';

  @override
  bool operator ==(covariant MoviesListState other) {
    if (identical(this, other)) {
      return true;
    }

    return other.popularMoviesContainer == popularMoviesContainer &&
        other.searchMoviesContainer == searchMoviesContainer &&
        other.searchQuery == searchQuery;
  }

  @override
  int get hashCode =>
      popularMoviesContainer.hashCode ^
      searchMoviesContainer.hashCode ^
      searchQuery.hashCode;
}
