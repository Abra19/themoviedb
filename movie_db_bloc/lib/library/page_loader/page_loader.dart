import 'package:the_movie_db/domain/server_entities/movies/movies.dart';
import 'package:the_movie_db/domain/server_entities/movies/popular_movie_response.dart';
import 'package:the_movie_db/domain/states/movies_state.dart';

abstract class PageLoader {
  static Future<MoviesContainer?> loadNextPage(
    MoviesContainer moviesContainer,
    Future<PopularMovieResponse> Function(int) loader,
  ) async {
    if (moviesContainer.isComplete) {
      return null;
    }
    final int nextPage = moviesContainer.currentPage + 1;

    final PopularMovieResponse result = await loader(nextPage);
    final List<Movie> movies = List<Movie>.from(moviesContainer.movies)
      ..addAll(result.movies);
    final MoviesContainer container = moviesContainer.copyWith(
      movies: movies,
      currentPage: result.page,
      totalPages: result.totalPages,
    );
    return container;
  }
}
