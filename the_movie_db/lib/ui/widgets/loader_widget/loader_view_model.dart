import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/services/auth_service.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class LoaderViewModel {
  LoaderViewModel(this.context) {
    checkAuth();
  }
  final AuthService _authService = AuthService();
  final BuildContext context;

  Future<void> checkAuth() async {
    final bool isAuth = await _authService.isAuth();
    final String nextScreen = isAuth
        ? MainNavigationRouteNames.mainScreen
        : MainNavigationRouteNames.auth;
    if (context.mounted) {
      Navigator.of(context).pushReplacementNamed(nextScreen);
    }
  }
}
