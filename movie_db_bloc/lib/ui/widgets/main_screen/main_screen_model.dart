import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/services/auth_service.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class MainScreenViewModel extends ChangeNotifier {
  MainScreenViewModel();
  final AuthService _authService = AuthService();

  Future<void> onLogoutButtonPressed(BuildContext context) async {
    await _authService.logout();
    if (context.mounted) {
      MainNavigation.resetNavigation(context);
    }
  }
}
