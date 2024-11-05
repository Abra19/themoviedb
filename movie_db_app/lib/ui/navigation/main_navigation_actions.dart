import 'package:flutter/material.dart';
import 'package:the_movie_db/ui/navigation/main_navigation_routes.dart';

class MainNavigationActions {
  const MainNavigationActions();

  void resetNavigation(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      MainNavigationRouteNames.loader,
      (_) => false,
    );
  }
}
