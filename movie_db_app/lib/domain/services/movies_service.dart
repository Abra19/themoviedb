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

abstract class MoviesService {
  Future<PopularMovieResponse> getPopularMovies(
    int page,
    String locale,
  );
  Future<PopularMovieResponse> getPopularShows(
    int page,
    String locale,
  );
  Future<PopularMovieResponse> searchMovies(
    int page,
    String locale,
    String query,
  );
  Future<PopularMovieResponse> searchShows(
    int page,
    String locale,
    String query,
  );
  List<DataStructure> makeDataStructure(
    List<Movie> movies,
    DateFormat dateFormat,
  );
  MovieListRowData makeRowData(Movie movie, DateFormat dateFormat);
  void handleAPIClientException(
    ApiClientException error,
    Function()? onSessionExpired,
  );
  List<bool> changeSelector(List<bool> current, int index);
  Future<MoviesDetailsLocal> loadMovieDetails({
    required int movieId,
    required String locale,
  });
  Future<ShowsDetailsLocal> loadShowDetails({
    required int showId,
    required String locale,
  });
  Future<void> postInFavoriteOnClick({
    required int movieId,
    required bool isFavorite,
    required MediaType mediaType,
  });
  Future<PopularMovieResponse?> getFavoriteMovies({
    required int page,
    required String locale,
  });
  Future<PopularMovieResponse?> getFavoriteShows({
    required int page,
    required String locale,
  });
}

class MoviesServiceBasic implements MoviesService {
  const MoviesServiceBasic({
    required this.apiClient,
    required this.sessionDataProvider,
  });

  final ApiClientFactory apiClient;
  final SessionDataProvider sessionDataProvider;

  @override
  Future<PopularMovieResponse> getPopularMovies(
    int page,
    String locale,
  ) =>
      apiClient.popularMovie(page, locale);

  @override
  Future<PopularMovieResponse> getPopularShows(
    int page,
    String locale,
  ) =>
      apiClient.popularShows(page, locale);

  @override
  Future<PopularMovieResponse> searchMovies(
    int page,
    String locale,
    String query,
  ) =>
      apiClient.searchMovie(page, locale, query);

  @override
  Future<PopularMovieResponse> searchShows(
    int page,
    String locale,
    String query,
  ) =>
      apiClient.searchTV(page, locale, query);

  @override
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

  @override
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

  @override
  List<bool> changeSelector(List<bool> current, int index) {
    return current
        .asMap()
        .entries
        .map((MapEntry<int, bool> el) => el.key == index)
        .toList();
  }

  @override
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

  @override
  Future<MoviesDetailsLocal> loadMovieDetails({
    required int movieId,
    required String locale,
  }) async {
    final MovieDetails movieDetails =
        await apiClient.getMovieDetails(movieId, locale);
    final String? token = await sessionDataProvider.getSessionId();
    bool isFavorite = false;
    if (token != null) {
      final String result = await apiClient.isMovieInFavorites(movieId, token);
      isFavorite = result == 'true';
    }
    return MoviesDetailsLocal(
      details: movieDetails,
      isFavorite: isFavorite,
    );
  }

  @override
  Future<ShowsDetailsLocal> loadShowDetails({
    required int showId,
    required String locale,
  }) async {
    final ShowDetails showDetails =
        await apiClient.getShowDetails(showId, locale);
    final String? token = await sessionDataProvider.getSessionId();
    bool isFavorite = false;
    if (token != null) {
      final String result = await apiClient.isShowInFavorites(showId, token);
      isFavorite = result == 'true';
    }
    return ShowsDetailsLocal(
      details: showDetails,
      isFavorite: isFavorite,
    );
  }

  @override
  Future<void> postInFavoriteOnClick({
    required int movieId,
    required bool isFavorite,
    required MediaType mediaType,
  }) async {
    final String? token = await sessionDataProvider.getSessionId();
    if (token == null) {
      return;
    }
    await apiClient.postInFavorites(
      mediaType: mediaType,
      mediaId: movieId,
      isFavorite: !isFavorite,
      token: token,
    );
  }

  @override
  Future<PopularMovieResponse?> getFavoriteMovies({
    required int page,
    required String locale,
  }) async {
    final String? token = await sessionDataProvider.getSessionId();
    if (token == null) {
      return null;
    }
    return apiClient.getFavoriteMovies(locale, page, token);
  }

  @override
  Future<PopularMovieResponse?> getFavoriteShows({
    required int page,
    required String locale,
  }) async {
    final String? token = await sessionDataProvider.getSessionId();
    if (token == null) {
      return null;
    }
    return apiClient.getFavoriteShows(locale, page, token);
  }
}
