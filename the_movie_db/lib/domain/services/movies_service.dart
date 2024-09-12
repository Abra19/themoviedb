import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/entities/movies/popular_movie_response.dart';

class MoviesService {
  final ApiClient _apiClient = ApiClient();

  Future<PopularMovieResponse> getPopularMovies(
    int page,
    String locale,
  ) =>
      _apiClient.popularMovie(page, locale);

  Future<PopularMovieResponse> searchMovies(
    int page,
    String locale,
    String query,
  ) =>
      _apiClient.searchMovie(page, locale, query);
}
