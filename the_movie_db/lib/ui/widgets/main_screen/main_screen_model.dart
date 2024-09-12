import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/services/auth_service.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class MainScreenViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  Future<void> onLogoutButtonPressed(BuildContext context) async {
    await _authService.logout();
    if (context.mounted) {
      Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.auth);
    }
  }

  Future<void> onRefreshButtonPressed(int index) async {
    // errorMessage = null; - to do - in model - in depend on index - resetList and errormessage null
    switch (index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
    }
  }
}
