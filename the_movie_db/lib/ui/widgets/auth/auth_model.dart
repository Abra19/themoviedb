import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/data_providers/session_data_provider.dart';
import 'package:the_movie_db/domain/exceptions/api_client_exceptions.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class AuthModel extends ChangeNotifier {
  final ApiClient _apiClient = ApiClient();
  final TextEditingController loginTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController phoneTextController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool isAuthInProgress = false;
  bool get canStartAuth => !isAuthInProgress;

  final SessionDataProvider _sessionDataProvider = SessionDataProvider();

  Future<void> auth(BuildContext context) async {
    final String username = loginTextController.text;
    final String password = passwordTextController.text;

    if (username.isEmpty || password.isEmpty) {
      _errorMessage = 'Enter both username and password';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    isAuthInProgress = true;
    notifyListeners();
    try {
      final String sessionId = await _apiClient.auth(
        username: username,
        password: password,
      );
      await _sessionDataProvider.setSessionId(sessionId);
      if (context.mounted) {
        await Navigator.of(context)
            .pushReplacementNamed(MainNavigationRouteNames.root);
      }
    } on ApiClientException catch (error) {
      switch (error.type) {
        case ApiClientExceptionType.network:
          _errorMessage = 'No internet connection';
        case ApiClientExceptionType.auth:
          _errorMessage = 'Invalid login or password';
        case ApiClientExceptionType.api:
          _errorMessage = 'Invalid API key';
        default:
          _errorMessage = 'Something went wrong, try again later';
      }
    } catch (_) {
      _errorMessage = 'Unexpected error, try again later';
    } finally {
      isAuthInProgress = false;
      notifyListeners();
    }
  }

  void onTapLogin() {
    loginTextController.clear();
  }

  void onTapPassword() {
    passwordTextController.clear();
  }
}
