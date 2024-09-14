import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/entities/movies/movies.dart';
import 'package:the_movie_db/domain/entities/movies/popular_movie_response.dart';
import 'package:the_movie_db/library/dates/date_string_from_date.dart';
import 'package:the_movie_db/types/types.dart';

class MoviesService {
  final ApiClient _apiClient = ApiClient();

  Future<PopularMovieResponse> getPopularMovies(
    int page,
    String locale,
  ) =>
      _apiClient.popularMovie(page, locale);

  Future<PopularMovieResponse> getPopularShows(
    int page,
    String locale,
  ) =>
      _apiClient.popularShows(page, locale);

  Future<PopularMovieResponse> searchMovies(
    int page,
    String locale,
    String query,
  ) =>
      _apiClient.searchMovie(page, locale, query);

  Future<PopularMovieResponse> searchShows(
    int page,
    String locale,
    String query,
  ) =>
      _apiClient.searchTV(page, locale, query);

  List<DataStructure> makeDataStructure(
    List<Movie> movies,
    DateFormat dateFormat,
  ) =>
      movies
          .map(
            (Movie movie) => DataStructure(
              id: movie.id,
              posterPath: movie.posterPath,
              title: movie.title ?? movie.name,
              percent: movie.voteAverage * 10,
              date: stringFromDate(
                movie.releaseDate ?? movie.firstAirDate,
                dateFormat,
              ),
              type: movie.mediaType,
            ),
          )
          .toList();

  List<bool> changeSelector(List<bool> current, int index) {
    return current
        .asMap()
        .entries
        .map((MapEntry<int, bool> el) => el.key == index)
        .toList();
  }

  MovieListRowData makeRowData(Movie movie, DateFormat dateFormat) {
    final DateTime? movieDate = movie.releaseDate;
    final DateTime? showDate = movie.firstAirDate;
    final String? releaseDate =
        movieDate != null ? stringFromDate(movieDate, dateFormat) : null;
    final String? firstAirDate =
        showDate != null ? stringFromDate(showDate, dateFormat) : null;
    return MovieListRowData(
      id: movie.id,
      title: movie.title,
      name: movie.name,
      posterPath: movie.posterPath,
      releaseDate: releaseDate,
      firstAirDate: firstAirDate,
      overview: movie.overview,
    );
  }
}
