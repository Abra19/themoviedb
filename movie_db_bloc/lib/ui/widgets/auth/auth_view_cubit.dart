// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_db/constants/errors_text.dart';
import 'package:the_movie_db/domain/blocs/auth_bloc.dart';
import 'package:the_movie_db/domain/events/auth_events.dart';
import 'package:the_movie_db/domain/exceptions/api_client_exceptions.dart';
import 'package:the_movie_db/domain/exceptions/handle_errors.dart';
import 'package:the_movie_db/domain/states/auth_state.dart';

abstract class AuthCubitState {}

class AuthCubitStateInitAuth extends AuthCubitState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthCubitStateInitAuth && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthCubitStateError extends AuthCubitState {
  AuthCubitStateError(this.errorMessage);
  final String errorMessage;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthCubitStateError &&
          runtimeType == other.runtimeType &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => errorMessage.hashCode;
}

class AuthCubitStateLoading extends AuthCubitState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthCubitStateLoading && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthCubitStateSuccess extends AuthCubitState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthCubitStateSuccess && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthViewCubit extends Cubit<AuthCubitState> {
  AuthViewCubit({
    required this.authBlock,
    required AuthCubitState initialState,
  }) : super(initialState) {
    _onState(authBlock.state);
    authBlockSubscription = authBlock.stream.listen(_onState);
  }

  final AuthBloc authBlock;
  late final StreamSubscription<AuthState> authBlockSubscription;

  void _onState(AuthState state) {
    if (state is AuthUnauthorizedState) {
      emit(AuthCubitStateInitAuth());
    } else if (state is AuthAuthorizedState) {
      authBlockSubscription.cancel();
      emit(AuthCubitStateSuccess());
    } else if (state is AuthFailState) {
      state.error is ApiClientException
          ? emit(
              AuthCubitStateError(
                handleErrors(state.error as ApiClientException),
              ),
            )
          : emit(AuthCubitStateError(unknownErrorText));
    } else if (state is AuthProcessState || state is AuthCheckState) {
      emit(AuthCubitStateLoading());
    }
  }

  bool _isValid(String login, String password) =>
      login.isNotEmpty && password.isNotEmpty;

  Future<void> onLoginPressed({
    required String login,
    required String password,
  }) async {
    if (!_isValid(login, password)) {
      final AuthCubitStateError newState = AuthCubitStateError(emptyErrorText);
      emit(newState);
      return;
    }
    emit(AuthCubitStateLoading());
    authBlock.add(LoginEvent(login: login, password: password));
  }

  Future<void> onLogoutPressed() async {
    emit(AuthCubitStateInitAuth());
    authBlock.add(LogoutEvent());
  }

  @override
  Future<void> close() {
    authBlockSubscription.cancel();
    return super.close();
  }
}
