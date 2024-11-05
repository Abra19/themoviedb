import 'package:flutter/material.dart';
import 'package:the_movie_db/ui/navigation/main_navigation_actions.dart';

abstract class MainScreenViewModelLogoutProvider {
  Future<void> logout();
}

class MainScreenViewModel extends ChangeNotifier {
  MainScreenViewModel({
    required this.logoutProvider,
    required this.navigationActions,
  });
  final MainScreenViewModelLogoutProvider logoutProvider;
  final MainNavigationActions navigationActions;

  Future<void> onLogoutButtonPressed(BuildContext context) async {
    await logoutProvider.logout();
    if (context.mounted) {
      navigationActions.resetNavigation(context);
    }
  }
}
