import 'package:the_movie_db/constants/media_type_enum.dart';
import 'package:the_movie_db/di/di_container.dart';
import 'package:the_movie_db/domain/server_entities/actors/actor_details.dart';
import 'package:the_movie_db/domain/server_entities/movie_details/movie_details.dart';
import 'package:the_movie_db/domain/server_entities/movies/popular_movie_response.dart';
import 'package:the_movie_db/domain/server_entities/show_details/show_details.dart';

abstract class ApiClientFactory {
  Future<String> auth({
    required String username,
    required String password,
  });
  Future<PopularMovieResponse> popularMovie(int page, String locale);
  Future<PopularMovieResponse> searchMovie(
    int page,
    String locale,
    String query,
  );
  Future<ActorDetails> showActor(
    int actorId,
    String locale,
  );
  Future<MovieDetails> getMovieDetails(
    int movieId,
    String locale,
  );
  Future<PopularMovieResponse> popularShows(int page, String locale);
  Future<PopularMovieResponse> searchTV(
    int page,
    String locale,
    String query,
  );
  Future<ShowDetails> getShowDetails(
    int showId,
    String locale,
  );
  Future<PopularMovieResponse> getAllInTrend(
    String trendPeriod,
    String locale,
  );
  Future<PopularMovieResponse> getNewMovies(
    String regionValue,
    String locale,
  );
  Future<PopularMovieResponse> getNewShows(
    String regionValue,
    String locale,
  );
  Future<PopularMovieResponse> getPlayingMovies(
    String regionValue,
    String locale,
  );
  Future<PopularMovieResponse> getPlayingShows(
    String regionValue,
    String locale,
  );
  Future<String> isMovieInFavorites(
    int movieId,
    String token,
  );
  Future<String> isShowInFavorites(
    int showId,
    String token,
  );
  Future<String> postInFavorites({
    required MediaType mediaType,
    required int mediaId,
    required bool isFavorite,
    required String token,
  });
  Future<PopularMovieResponse> getFavoriteMovies(
    String locale,
    int page,
    String token,
  );
  Future<PopularMovieResponse> getFavoriteShows(
    String locale,
    int page,
    String token,
  );
}

class ApiClient implements ApiClientFactory {
  ApiClient({required this.diContainer});

  final DIContainer diContainer;
  @override
  Future<String> auth({
    required String username,
    required String password,
  }) =>
      diContainer
          .makeAuthApiClient()
          .auth(username: username, password: password);

  @override
  Future<PopularMovieResponse> popularMovie(int page, String locale) =>
      diContainer.makeMoviesApiClient().popularMovie(page, locale);

  @override
  Future<PopularMovieResponse> searchMovie(
    int page,
    String locale,
    String query,
  ) =>
      diContainer.makeMoviesApiClient().searchMovie(page, locale, query);

  @override
  Future<ActorDetails> showActor(
    int actorId,
    String locale,
  ) =>
      diContainer.makeActorApiClient().showActor(actorId, locale);

  @override
  Future<MovieDetails> getMovieDetails(
    int movieId,
    String locale,
  ) =>
      diContainer.makeMoviesApiClient().getMovieDetails(movieId, locale);

  @override
  Future<PopularMovieResponse> popularShows(int page, String locale) =>
      diContainer.makeShowsApiClient().popularShows(page, locale);

  @override
  Future<PopularMovieResponse> searchTV(
    int page,
    String locale,
    String query,
  ) =>
      diContainer.makeShowsApiClient().searchTV(page, locale, query);

  @override
  Future<ShowDetails> getShowDetails(
    int showId,
    String locale,
  ) =>
      diContainer.makeShowsApiClient().getShowDetails(showId, locale);

  @override
  Future<PopularMovieResponse> getAllInTrend(
    String trendPeriod,
    String locale,
  ) =>
      diContainer.makeTrendingApiClient().getAllInTrend(trendPeriod, locale);

  @override
  Future<PopularMovieResponse> getNewMovies(
    String regionValue,
    String locale,
  ) =>
      diContainer.makeMoviesApiClient().getNewMovies(regionValue, locale);

  @override
  Future<PopularMovieResponse> getNewShows(
    String regionValue,
    String locale,
  ) =>
      diContainer.makeShowsApiClient().getNewShows(regionValue, locale);

  @override
  Future<PopularMovieResponse> getPlayingMovies(
    String regionValue,
    String locale,
  ) =>
      diContainer.makeMoviesApiClient().getPlayingMovies(regionValue, locale);

  @override
  Future<PopularMovieResponse> getPlayingShows(
    String regionValue,
    String locale,
  ) =>
      diContainer.makeShowsApiClient().getPlayingShows(regionValue, locale);

  @override
  Future<String> isMovieInFavorites(
    int movieId,
    String token,
  ) =>
      diContainer.makeFavoritesApiClient().isMovieInFavorites(movieId, token);

  @override
  Future<String> isShowInFavorites(
    int showId,
    String token,
  ) =>
      diContainer.makeFavoritesApiClient().isShowInFavorites(showId, token);

  @override
  Future<String> postInFavorites({
    required MediaType mediaType,
    required int mediaId,
    required bool isFavorite,
    required String token,
  }) =>
      diContainer.makeFavoritesApiClient().postInFavorites(
            mediaType: mediaType,
            mediaId: mediaId,
            isFavorite: isFavorite,
            token: token,
          );

  @override
  Future<PopularMovieResponse> getFavoriteMovies(
    String locale,
    int page,
    String token,
  ) =>
      diContainer
          .makeFavoritesApiClient()
          .getFavoriteMovies(locale, page, token);

  @override
  Future<PopularMovieResponse> getFavoriteShows(
    String locale,
    int page,
    String token,
  ) =>
      diContainer
          .makeFavoritesApiClient()
          .getFavoriteShows(locale, page, token);
}
