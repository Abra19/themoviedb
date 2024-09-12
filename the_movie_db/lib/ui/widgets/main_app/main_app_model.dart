import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/data_providers/session_data_provider.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class MainAppModel {
  final SessionDataProvider sessionDataProvider = SessionDataProvider();

  bool _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    _isAuth = await sessionDataProvider.getSessionId() != null;
  }

  Future<void> resetSession(BuildContext context) async {
    _isAuth = false;
    await Navigator.of(context).pushReplacementNamed(
      MainNavigationRouteNames.auth,
    );
    await sessionDataProvider.setSessionId(null);
  }
}
