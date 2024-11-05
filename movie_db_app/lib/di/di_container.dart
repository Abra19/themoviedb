import 'package:flutter/material.dart';
import 'package:the_movie_db/di/screens_factory.dart';
import 'package:the_movie_db/domain/api_client/actor_api_client.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/api_client/auth_api_client.dart';
import 'package:the_movie_db/domain/api_client/favorites_api_client.dart';
import 'package:the_movie_db/domain/api_client/movies_api_client.dart';
import 'package:the_movie_db/domain/api_client/network_client.dart';
import 'package:the_movie_db/domain/api_client/shows_api_client.dart';
import 'package:the_movie_db/domain/api_client/trending_api_client.dart';
import 'package:the_movie_db/domain/data_providers/session_data_provider.dart';
import 'package:the_movie_db/domain/services/actors_service.dart';
import 'package:the_movie_db/domain/services/auth_service.dart';
import 'package:the_movie_db/domain/services/movies_service.dart';
import 'package:the_movie_db/library/flutter_secure_storage/secure_storage.dart';
import 'package:the_movie_db/library/http_client/app_http_client.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';
import 'package:the_movie_db/ui/navigation/main_navigation_actions.dart';
import 'package:the_movie_db/ui/widgets/actor_details/actor_details_model.dart';
import 'package:the_movie_db/ui/widgets/auth/auth_model.dart';
import 'package:the_movie_db/ui/widgets/favorites/favorite_model.dart';
import 'package:the_movie_db/ui/widgets/loader_widget/loader_view_model.dart';
import 'package:the_movie_db/ui/widgets/main_app/main_app_widget.dart';
import 'package:the_movie_db/ui/widgets/main_screen/main_screen_model.dart';
import 'package:the_movie_db/ui/widgets/movie_details/movie_details_model.dart';
import 'package:the_movie_db/ui/widgets/movie_screen/movies_model.dart';
import 'package:the_movie_db/ui/widgets/news_screen/new_movies/new_movies_view_model.dart';
import 'package:the_movie_db/ui/widgets/news_screen/playing_movies/playing_view_model.dart';
import 'package:the_movie_db/ui/widgets/news_screen/trended_movies/trended_view_model.dart';
import 'package:the_movie_db/ui/widgets/tv_shows_details/tv_details_model.dart';
import 'package:the_movie_db/ui/widgets/tv_shows_screen/tv_shows_model.dart';

abstract class AppFactory {
  Widget makeApp();
}

class _AppFactoryBasic implements AppFactory {
  _AppFactoryBasic() {
    _diContainer = DIContainer();
  }

  late final DIContainer _diContainer;

  @override
  Widget makeApp() => MainApp(
        navigation: _diContainer._makeMyAppNavigation(),
      );
}

AppFactory makeAppFactory() => _AppFactoryBasic();

class DIContainer {
  DIContainer();

  final MainNavigationActions _mainNavigationActions =
      const MainNavigationActions();
  final SecureStorage _secureStorage = const SecureStorageBasic();
  final AppHttpClient _appHttpClient = AppHttpClientBasic();

  ScreensFactory _makeScreensFactory() =>
      ScreensFactoryBasic(diContainer: this);

  MyAppNavigation _makeMyAppNavigation() =>
      MainNavigation(screensFactory: _makeScreensFactory());

  SessionDataProvider _makeSessionDataProvider() =>
      SessionDataProviderBasic(secureStorage: _secureStorage);

  NetworkClient _makeNetworkClient() => NetworkClientBasic(
        client: _appHttpClient,
      );

  AuthApiClient makeAuthApiClient() => AuthApiClientBasic(
        networkClient: _makeNetworkClient(),
      );

  ActorApiClient makeActorApiClient() => ActorApiClientBasic(
        networkClient: _makeNetworkClient(),
      );

  FavoritesApiClient makeFavoritesApiClient() => FavoritesApiClientBasic(
        networkClient: _makeNetworkClient(),
      );

  MoviesApiClient makeMoviesApiClient() => MoviesApiClientBasic(
        networkClient: _makeNetworkClient(),
      );

  ShowsApiClient makeShowsApiClient() => ShowsApiClientBasic(
        networkClient: _makeNetworkClient(),
      );

  TrendingApiClient makeTrendingApiClient() => TrendingApiClientBasic(
        networkClient: _makeNetworkClient(),
      );

  ApiClientFactory makeApiClientFactory() => ApiClient(diContainer: this);

  AuthServiceBasic makeAuthService() => AuthServiceBasic(
        sessionDataProvider: _makeSessionDataProvider(),
        apiClient: makeAuthApiClient(),
      );
  MoviesService makeMoviesService() => MoviesServiceBasic(
        apiClient: makeApiClientFactory(),
        sessionDataProvider: _makeSessionDataProvider(),
      );

  ActorsService makeActorsService() => ActorsServiceBasic(
        apiClient: makeApiClientFactory(),
      );

  AuthViewModel makeAuthViewModel() => AuthViewModel(
        loginProvider: makeAuthService(),
        navigationActions: _mainNavigationActions,
      );

  MainScreenViewModel makeMainScreenViewModel() => MainScreenViewModel(
        logoutProvider: makeAuthService(),
        navigationActions: _mainNavigationActions,
      );

  ActorDetailsViewModel makeActorDetails(int actorId) => ActorDetailsViewModel(
        actorId,
        makeActorsService(),
      );

  FavoriteViewModel makeFavoriteViewModel() =>
      FavoriteViewModel(makeMoviesService());

  LoaderViewModel makeLoader(BuildContext context) =>
      LoaderViewModel(context, makeAuthService());

  MovieDetailsViewModel makeMovieDetails(int movieId) => MovieDetailsViewModel(
        movieId,
        makeMoviesService(),
      );

  MoviesViewModel makeMoviesList() => MoviesViewModel(
        makeMoviesService(),
      );

  NewMoviesViewModel makeNewMovies() => NewMoviesViewModel(
        apiClient: makeApiClientFactory(),
        movieService: makeMoviesService(),
      );

  PlayingMoviesViewModel makePlayingMovies() => PlayingMoviesViewModel(
        apiClient: makeApiClientFactory(),
        movieService: makeMoviesService(),
      );

  TrendedViewModel makeTrendedMovies() => TrendedViewModel(
        apiClient: makeApiClientFactory(),
        movieService: makeMoviesService(),
      );

  TVDetailsViewModel makeTVDetails(int seriesId) => TVDetailsViewModel(
        seriesId,
        makeMoviesService(),
      );

  TVShowsViewModel makeTVList() => TVShowsViewModel(
        makeMoviesService(),
      );
}
