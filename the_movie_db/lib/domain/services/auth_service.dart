import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/data_providers/session_data_provider.dart';

class AuthService {
  final SessionDataProvider _sessionDataProvider = SessionDataProvider();
  final ApiClient _apiClient = ApiClient();

  Future<bool> isAuth() async {
    final String? sessionId = await _sessionDataProvider.getSessionId();
    return sessionId != null;
  }

  Future<void> login(String login, String password) async {
    final String sessionId = await _apiClient.auth(
      username: login,
      password: password,
    );
    await _sessionDataProvider.setSessionId(sessionId);
  }

  Future<void> logout() async {
    await _sessionDataProvider.clearStorage();
  }
}
