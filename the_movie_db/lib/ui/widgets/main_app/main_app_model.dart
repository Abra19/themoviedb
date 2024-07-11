import 'package:the_movie_db/domain/data_providers/session_data_provider.dart';

class MainAppModel {
  final SessionDataProvider sessionDataProvider = SessionDataProvider();

  bool _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    _isAuth = await sessionDataProvider.getSessionId() != null;
  }
}
