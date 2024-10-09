abstract class AuthEvents {}

class LoginEvent extends AuthEvents {
  LoginEvent({
    required this.login,
    required this.password,
  });

  final String login;
  final String password;
}

class LogoutEvent extends AuthEvents {}

class CheckAuthEvent extends AuthEvents {}
