import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/factories/screen_factories.dart';

class MainNavigationRouteNames {
  static const String loader = '/';
  static const String auth = 'auth';
  static const String mainScreen = '/main_screen';
  static const String movieDetails = '/main_screen/movie_details';
  static const String tvDetails = '/main_screen/tv_details';
  static const String movieDetailsActor = '/main_screen/movie_details/actor';
  static const String movieDetailsTrailer =
      '/main_screen/movie_details/trailer';
}

class MainNavigation {
  final String initialRoute = MainNavigationRouteNames.loader;
  static final ScreenFactories _screenFactory = ScreenFactories();

  final Map<String, Widget Function(BuildContext p1)> routes =
      <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.loader: (_) => _screenFactory.makeLoader(),
    MainNavigationRouteNames.mainScreen: (_) => _screenFactory.makeMainScreen(),
    MainNavigationRouteNames.auth: (_) => _screenFactory.makeAuth(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetails:
        final Object? argument = settings.arguments;
        final int movieId = argument is int ? argument : 0;
        return MaterialPageRoute<Object>(
          builder: (_) => _screenFactory.makeMovieDetails(movieId),
        );
      case MainNavigationRouteNames.movieDetailsActor:
        final Object? argument = settings.arguments;
        final int actorId = argument is int ? argument : 0;
        return MaterialPageRoute<Object>(
          builder: (_) => _screenFactory.makeActorDetails(actorId),
        );
      case MainNavigationRouteNames.movieDetailsTrailer:
        final Object? argument = settings.arguments;
        final String trailerKey = argument is String ? argument : '';
        return MaterialPageRoute<Object>(
          builder: (_) => _screenFactory.makeTrailer(trailerKey),
        );
      case MainNavigationRouteNames.tvDetails:
        final Object? argument = settings.arguments;
        final int seriesId = argument is int ? argument : 0;
        return MaterialPageRoute<Object>(
          builder: (_) => _screenFactory.makeTVDetails(seriesId),
        );
      default:
        const Text widget = Text('Navigation error!');
        return MaterialPageRoute<Object>(
          builder: (_) => widget,
        );
    }
  }

  static void resetNavigation(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      MainNavigationRouteNames.loader,
      (_) => false,
    );
  }
}
