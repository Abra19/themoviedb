import 'package:the_movie_db/constants/media_type_enum.dart';
import 'package:the_movie_db/domain/api_client/actor_api_client.dart';
import 'package:the_movie_db/domain/api_client/auth_api_client.dart';
import 'package:the_movie_db/domain/api_client/favorites_api_client.dart';
import 'package:the_movie_db/domain/api_client/movies_api_client.dart';
import 'package:the_movie_db/domain/api_client/shows_api_client.dart';
import 'package:the_movie_db/domain/api_client/trending_api_client.dart';
import 'package:the_movie_db/domain/entities/actors/actor_details.dart';
import 'package:the_movie_db/domain/entities/movie_details/movie_details.dart';
import 'package:the_movie_db/domain/entities/movies/popular_movie_response.dart';
import 'package:the_movie_db/domain/entities/show_details/show_details.dart';

class ApiClient {
  Future<String> auth({
    required String username,
    required String password,
  }) =>
      AuthApiClient().auth(username: username, password: password);

  Future<PopularMovieResponse> popularMovie(int page, String locale) =>
      MoviesApiClient().popularMovie(page, locale);

  Future<PopularMovieResponse> searchMovie(
    int page,
    String locale,
    String query,
  ) =>
      MoviesApiClient().searchMovie(page, locale, query);

  Future<ActorDetails> showActor(
    int actorId,
    String locale,
  ) =>
      ActorApiClient().showActor(actorId, locale);

  Future<MovieDetails> getMovieDetails(
    int movieId,
    String locale,
  ) =>
      MoviesApiClient().getMovieDetails(movieId, locale);

  Future<PopularMovieResponse> popularShows(int page, String locale) =>
      ShowsApiClient().popularShows(page, locale);

  Future<PopularMovieResponse> searchTV(
    int page,
    String locale,
    String query,
  ) =>
      ShowsApiClient().searchTV(page, locale, query);

  Future<ShowDetails> getShowDetails(
    int showId,
    String locale,
  ) =>
      ShowsApiClient().getShowDetails(showId, locale);

  Future<PopularMovieResponse> getAllInTrend(
    String trendPeriod,
    String locale,
  ) =>
      TrendingApiClient().getAllInTrend(trendPeriod, locale);

  Future<PopularMovieResponse> getNewMovies(
    String regionValue,
    String locale,
  ) =>
      MoviesApiClient().getNewMovies(regionValue, locale);

  Future<PopularMovieResponse> getNewShows(
    String regionValue,
    String locale,
  ) =>
      ShowsApiClient().getNewShows(regionValue, locale);

  Future<PopularMovieResponse> getPlayingMovies(
    String regionValue,
    String locale,
  ) =>
      MoviesApiClient().getPlayingMovies(regionValue, locale);

  Future<PopularMovieResponse> getPlayingShows(
    String regionValue,
    String locale,
  ) =>
      ShowsApiClient().getPlayingShows(regionValue, locale);

  Future<String> isMovieInFavorites(
    int movieId,
    String token,
  ) =>
      FavoritesApiClient().isMovieInFavorites(movieId, token);

  Future<String> isShowInFavorites(
    int showId,
    String token,
  ) =>
      FavoritesApiClient().isShowInFavorites(showId, token);

  Future<String> postInFavorites({
    required MediaType mediaType,
    required int mediaId,
    required bool isFavorite,
    required String token,
  }) =>
      FavoritesApiClient().postInFavorites(
        mediaType: mediaType,
        mediaId: mediaId,
        isFavorite: isFavorite,
        token: token,
      );

  Future<PopularMovieResponse> getFavoriteMovies(
    String locale,
    int page,
    String token,
  ) =>
      FavoritesApiClient().getFavoriteMovies(locale, page, token);

  Future<PopularMovieResponse> getFavoriteShows(
    String locale,
    int page,
    String token,
  ) =>
      FavoritesApiClient().getFavoriteShows(locale, page, token);
}
