// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:the_movie_db/constants/media_type_enum.dart';
import 'package:the_movie_db/domain/server_entities/movies/movies.dart';
import 'package:the_movie_db/types/types.dart';

class FavoriteListsState {
  FavoriteListsState({
    required this.favoritesMovieContainer,
    required this.selectedType,
    required this.errorMessage,
  });

  FavoriteListsState.init()
      : favoritesMovieContainer = const MoviesContainer.init(),
        selectedType = MediaType.movie.name,
        errorMessage = '';

  final MoviesContainer favoritesMovieContainer;
  List<Movie> get movies => favoritesMovieContainer.movies;
  final String selectedType;
  final String errorMessage;

  FavoriteListsState copyWith({
    MoviesContainer? favoritesMovieContainer,
    String? selectedType,
    String? errorMessage,
  }) {
    return FavoriteListsState(
      favoritesMovieContainer:
          favoritesMovieContainer ?? this.favoritesMovieContainer,
      selectedType: selectedType ?? this.selectedType,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(covariant FavoriteListsState other) {
    if (identical(this, other)) {
      return true;
    }

    return other.favoritesMovieContainer == favoritesMovieContainer &&
        other.selectedType == selectedType &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      favoritesMovieContainer.hashCode ^
      selectedType.hashCode ^
      errorMessage.hashCode;
}
