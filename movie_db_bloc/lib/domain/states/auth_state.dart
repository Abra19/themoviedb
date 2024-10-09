// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class AuthState {}

class AuthUnauthorizedState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthUnauthorizedState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthAuthorizedState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthAuthorizedState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthFailState extends AuthState {
  AuthFailState(this.error);
  final Object error;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthFailState &&
          runtimeType == other.runtimeType &&
          other.error == error;

  @override
  int get hashCode => error.hashCode;
}

class AuthProcessState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthProcessState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthCheckState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthCheckState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
