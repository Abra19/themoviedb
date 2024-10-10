// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:the_movie_db/domain/server_entities/movies/movies.dart';
import 'package:the_movie_db/types/types.dart';

class ShowsListState {
  ShowsListState({
    required this.popularShowsContainer,
    required this.searchShowsContainer,
    required this.searchQuery,
    required this.errorMessage,
  });

  ShowsListState.init()
      : popularShowsContainer = const MoviesContainer.init(),
        searchShowsContainer = const MoviesContainer.init(),
        searchQuery = '',
        errorMessage = null;

  final MoviesContainer popularShowsContainer;
  final MoviesContainer searchShowsContainer;
  final String searchQuery;
  String? errorMessage;

  bool get isSearchMode => searchQuery.isNotEmpty;

  List<Movie> get shows =>
      isSearchMode ? searchShowsContainer.movies : popularShowsContainer.movies;

  ShowsListState copyWith({
    MoviesContainer? popularShowsContainer,
    MoviesContainer? searchShowsContainer,
    String? searchQuery,
    String? errorMessage,
  }) {
    return ShowsListState(
      popularShowsContainer:
          popularShowsContainer ?? this.popularShowsContainer,
      searchShowsContainer: searchShowsContainer ?? this.searchShowsContainer,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() =>
      'ShowsListState(popularShowsContainer: $popularShowsContainer, searchShowsContainer: $searchShowsContainer, searchQuery: $searchQuery)';

  @override
  bool operator ==(covariant ShowsListState other) {
    if (identical(this, other)) {
      return true;
    }

    return other.popularShowsContainer == popularShowsContainer &&
        other.searchShowsContainer == searchShowsContainer &&
        other.searchQuery == searchQuery;
  }

  @override
  int get hashCode =>
      popularShowsContainer.hashCode ^
      searchShowsContainer.hashCode ^
      searchQuery.hashCode;
}
