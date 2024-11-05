import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/exceptions/api_client_exceptions.dart';
import 'package:the_movie_db/domain/exceptions/handle_errors.dart';
import 'package:the_movie_db/ui/navigation/main_navigation_actions.dart';

enum AuthButtonStates {
  disabled,
  enabled,
  loading,
}

class AuthViewModelState {
  AuthViewModelState({
    this.login = '',
    this.password = '',
    this.errorMessage = '',
    this.authButtonStates = AuthButtonStates.disabled,
  });
  String login;
  String password;
  String? errorMessage;
  AuthButtonStates authButtonStates;
}

abstract class AuthViewModelLoginProvider {
  Future<void> login(String login, String password);
}

class AuthViewModel extends ChangeNotifier {
  AuthViewModel({
    required this.loginProvider,
    required this.navigationActions,
  });

  final MainNavigationActions navigationActions;
  final AuthViewModelLoginProvider loginProvider;

  final AuthViewModelState _state = AuthViewModelState();
  AuthViewModelState get state => _state;

  void checkButton() {
    if (_state.login.isEmpty || _state.password.isEmpty) {
      _state.authButtonStates = AuthButtonStates.disabled;
    } else {
      _state.authButtonStates = AuthButtonStates.enabled;
    }
    notifyListeners();
  }

  void setLogin(String value) {
    if (_state.login != value) {
      _state.login = value.trim();
      notifyListeners();
    }
    checkButton();
  }

  void setPassword(String value) {
    if (_state.password != value) {
      _state.password = value.trim();
      notifyListeners();
    }
    checkButton();
  }

  Future<void> onLoginPressed(BuildContext context) async {
    final String login = _state.login;
    final String password = _state.password;

    if (login.isEmpty || password.isEmpty) {
      _state.errorMessage = 'Login or password is empty';
      notifyListeners();
      return;
    }
    _state.errorMessage = '';
    _state.authButtonStates = AuthButtonStates.loading;
    notifyListeners();

    try {
      await loginProvider.login(login, password);
      if (context.mounted) {
        navigationActions.resetNavigation(context);
      }
    } on ApiClientException catch (error) {
      _state.errorMessage = handleErrors(error);
    } catch (_) {
      _state.errorMessage = 'Unexpected error, try again later';
    } finally {
      _state.authButtonStates = AuthButtonStates.enabled;
      notifyListeners();
    }
  }
}
