import 'package:flutter/material.dart';
import 'package:the_movie_db/library/providers/notify_provider.dart';
import 'package:the_movie_db/ui/widgets/actor_details/actor_details_widget.dart';
import 'package:the_movie_db/ui/widgets/auth/auth_model.dart';
import 'package:the_movie_db/ui/widgets/auth/auth_widget.dart';
import 'package:the_movie_db/ui/widgets/main_screen/main_screen_model.dart';
import 'package:the_movie_db/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:the_movie_db/ui/widgets/movie_details/movie_details_model.dart';
import 'package:the_movie_db/ui/widgets/movie_details/movie_details_widget.dart';

class MainNavigationRouteNames {
  static const String root = '/';
  static const String auth = 'auth';
  static const String movieDetails = '/movie_details';
  static const String movieDetailsActor = '/movie_details/actor';
}

class MainNavigation {
  String initialRoute(bool isAuth) =>
      isAuth ? MainNavigationRouteNames.root : MainNavigationRouteNames.auth;
  final Map<String, Widget Function(BuildContext p1)> routes =
      <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.root: (_) => NotifyProvider<MainScreenModel>(
          create: () => MainScreenModel(),
          child: const MainScreenWidget(),
        ),
    MainNavigationRouteNames.auth: (_) => NotifyProvider<AuthModel>(
          create: () => AuthModel(),
          child: const AuthWidget(),
        ),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetails:
        final Object? argument = settings.arguments;
        final int movieId = argument is int ? argument : 0;
        return MaterialPageRoute<Object>(
          builder: (BuildContext context) => NotifyProvider<MovieDetailsModel>(
            create: () => MovieDetailsModel(movieId),
            child: const MovieDetailsWidget(),
          ),
        );
      case MainNavigationRouteNames.movieDetailsActor:
        final Object? argument = settings.arguments;
        final int actorId = argument is int ? argument : 0;
        return MaterialPageRoute<Object>(
          builder: (BuildContext context) =>
              ActorDetailsWidget(actorId: actorId),
        );
      default:
        const Text widget = Text('Navigation error!');
        return MaterialPageRoute<Object>(
          builder: (BuildContext context) => widget,
        );
    }
  }
}
