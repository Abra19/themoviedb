import 'package:flutter/material.dart';
import 'package:the_movie_db/ui/navigation/main_navigation_routes.dart';

class NewsScreenViewModel extends ChangeNotifier {
  void onMovieClick(BuildContext context, int id, String type) {
    if (type == 'tv') {
      Navigator.of(context).pushNamed(
        MainNavigationRouteNames.tvDetails,
        arguments: id,
      );
    } else {
      Navigator.of(context).pushNamed(
        MainNavigationRouteNames.movieDetails,
        arguments: id,
      );
    }
  }
}
