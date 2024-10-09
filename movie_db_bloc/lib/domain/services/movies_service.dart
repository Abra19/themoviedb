import 'package:intl/intl.dart';
import 'package:the_movie_db/constants/media_type_enum.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/data_providers/session_data_provider.dart';
import 'package:the_movie_db/domain/exceptions/api_client_exceptions.dart';
import 'package:the_movie_db/domain/local_entities/movies_details_local.dart';
import 'package:the_movie_db/domain/local_entities/shows_details_local.dart';
import 'package:the_movie_db/domain/server_entities/movie_details/movie_details.dart';
import 'package:the_movie_db/domain/server_entities/movies/movies.dart';
import 'package:the_movie_db/domain/server_entities/movies/popular_movie_response.dart';
import 'package:the_movie_db/domain/server_entities/show_details/show_details.dart';
import 'package:the_movie_db/library/dates/handle_dates.dart';
import 'package:the_movie_db/types/types.dart';

class MoviesService {
  final ApiClient _apiClient = ApiClient();
  final SessionDataProvider sessionProvider = SessionDataProvider();

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
      mediaType: movie.mediaType,
    );
  }

  List<bool> changeSelector(List<bool> current, int index) {
    return current
        .asMap()
        .entries
        .map((MapEntry<int, bool> el) => el.key == index)
        .toList();
  }

  void handleAPIClientException(
    ApiClientException error,
    Function()? onSessionExpired,
  ) {
    switch (error.type) {
      case ApiClientExceptionType.sessionExpired:
        onSessionExpired?.call();
      default:
        break;
    }
  }

  Future<MoviesDetailsLocal> loadMovieDetails({
    required int movieId,
    required String locale,
  }) async {
    final MovieDetails movieDetails =
        await _apiClient.getMovieDetails(movieId, locale);
    final String? token = await sessionProvider.getSessionId();
    bool isFavorite = false;
    if (token != null) {
      final String result = await _apiClient.isMovieInFavorites(movieId, token);
      isFavorite = result == 'true';
    }
    return MoviesDetailsLocal(
      details: movieDetails,
      isFavorite: isFavorite,
    );
  }

  Future<ShowsDetailsLocal> loadShowDetails({
    required int showId,
    required String locale,
  }) async {
    final ShowDetails showDetails =
        await _apiClient.getShowDetails(showId, locale);
    final String? token = await sessionProvider.getSessionId();
    bool isFavorite = false;
    if (token != null) {
      final String result = await _apiClient.isShowInFavorites(showId, token);
      isFavorite = result == 'true';
    }
    return ShowsDetailsLocal(
      details: showDetails,
      isFavorite: isFavorite,
    );
  }

  Future<void> postInFavoriteOnClick({
    required int movieId,
    required bool isFavorite,
    required MediaType mediaType,
  }) async {
    final String? token = await sessionProvider.getSessionId();
    if (token == null) {
      return;
    }
    await _apiClient.postInFavorites(
      mediaType: mediaType,
      mediaId: movieId,
      isFavorite: !isFavorite,
      token: token,
    );
  }

  Future<PopularMovieResponse?> getFavoriteMovies({
    required int page,
    required String locale,
  }) async {
    final String? token = await sessionProvider.getSessionId();
    if (token == null) {
      return null;
    }
    return _apiClient.getFavoriteMovies(locale, page, token);
  }

  Future<PopularMovieResponse?> getFavoriteShows({
    required int page,
    required String locale,
  }) async {
    final String? token = await sessionProvider.getSessionId();
    if (token == null) {
      return null;
    }
    return _apiClient.getFavoriteShows(locale, page, token);
  }
}
