import 'package:flutter/material.dart';
import 'package:the_movie_db/ui/navigation/main_navigation_routes.dart';
import 'package:the_movie_db/ui/widgets/main_app/main_app_widget.dart';

abstract class ScreensFactory {
  Widget makeLoader();
  Widget makeAuth();
  Widget makeMainScreen();
  Widget makeNewsScreen();
  Widget makeTrendingMovies();
  Widget makeNewMovies();
  Widget makePlayingMovies();
  Widget makeMoviesList();
  Widget makeTVList();
  Widget makeMovieDetails(int movieId);
  Widget makeTVDetails(int seriesId);
  Widget makeActorDetails(int actorId);
  Widget makeFavoritesList();
  Widget makeTrailer(String trailerKey);
}

class MainNavigation implements MyAppNavigation {
  const MainNavigation({required this.screensFactory});

  final ScreensFactory screensFactory;

  @override
  Map<String, Widget Function(BuildContext)> get routes =>
      <String, Widget Function(BuildContext)>{
        MainNavigationRouteNames.loader: (_) => screensFactory.makeLoader(),
        MainNavigationRouteNames.mainScreen: (_) =>
            screensFactory.makeMainScreen(),
        MainNavigationRouteNames.auth: (_) => screensFactory.makeAuth(),
      };

  @override
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetails:
        final Object? argument = settings.arguments;
        final int movieId = argument is int ? argument : 0;
        return MaterialPageRoute<Object>(
          builder: (_) => screensFactory.makeMovieDetails(movieId),
        );
      case MainNavigationRouteNames.movieDetailsActor:
        final Object? argument = settings.arguments;
        final int actorId = argument is int ? argument : 0;
        return MaterialPageRoute<Object>(
          builder: (_) => screensFactory.makeActorDetails(actorId),
        );
      case MainNavigationRouteNames.movieDetailsTrailer:
        final Object? argument = settings.arguments;
        final String trailerKey = argument is String ? argument : '';
        return MaterialPageRoute<Object>(
          builder: (_) => screensFactory.makeTrailer(trailerKey),
        );
      case MainNavigationRouteNames.tvDetails:
        final Object? argument = settings.arguments;
        final int seriesId = argument is int ? argument : 0;
        return MaterialPageRoute<Object>(
          builder: (_) => screensFactory.makeTVDetails(seriesId),
        );
      default:
        const Text widget = Text('Navigation error!');
        return MaterialPageRoute<Object>(
          builder: (_) => widget,
        );
    }
  }
}
