import 'package:the_movie_db/domain/api_client/auth_api_client.dart';
import 'package:the_movie_db/domain/data_providers/session_data_provider.dart';
import 'package:the_movie_db/ui/widgets/auth/auth_model.dart';
import 'package:the_movie_db/ui/widgets/main_screen/main_screen_model.dart';

abstract class AuthService
    implements AuthViewModelLoginProvider, MainScreenViewModelLogoutProvider {
  Future<bool> isAuth();
  @override
  Future<void> login(String login, String password);
  @override
  Future<void> logout();
}

class AuthServiceBasic implements AuthService {
  const AuthServiceBasic({
    required this.sessionDataProvider,
    required this.apiClient,
  });

  final SessionDataProvider sessionDataProvider;
  final AuthApiClient apiClient;

  @override
  Future<bool> isAuth() async {
    final String? sessionId = await sessionDataProvider.getSessionId();
    return sessionId != null;
  }

  @override
  Future<void> login(String login, String password) async {
    final String sessionId = await apiClient.auth(
      username: login,
      password: password,
    );
    await sessionDataProvider.setSessionId(sessionId);
  }

  @override
  Future<void> logout() async {
    await sessionDataProvider.clearStorage();
  }
}
