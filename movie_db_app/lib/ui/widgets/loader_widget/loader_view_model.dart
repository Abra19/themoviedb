import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/services/auth_service.dart';
import 'package:the_movie_db/ui/navigation/main_navigation_routes.dart';

class LoaderViewModel {
  LoaderViewModel(this.context, this.authService) {
    try {
      checkAuth();
    } catch (_) {
      errorMessage = 'Something went wrong. Try again later';
    }
  }

  final AuthService authService;
  final BuildContext context;
  String errorMessage = '';

  Future<void> checkAuth() async {
    final bool isAuth = await authService.isAuth();
    final String nextScreen = isAuth
        ? MainNavigationRouteNames.mainScreen
        : MainNavigationRouteNames.auth;
    if (context.mounted) {
      Navigator.of(context).pushReplacementNamed(nextScreen);
    }
  }
}
