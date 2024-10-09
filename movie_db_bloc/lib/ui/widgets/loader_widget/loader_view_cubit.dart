import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:the_movie_db/domain/blocs/auth_bloc.dart';
import 'package:the_movie_db/domain/events/auth_events.dart';
import 'package:the_movie_db/domain/states/auth_state.dart';

enum LoaderStates {
  auth,
  notAuth,
  error,
  unknown,
}

class LoaderViewCubit extends Cubit<LoaderStates> {
  LoaderViewCubit({
    required this.authBlock,
    required LoaderStates initialState,
  }) : super(initialState) {
    Future<void>.microtask(() {
      _onState(authBlock.state);
      authBlockSubscription = authBlock.stream.listen(_onState);
      authBlock.add(CheckAuthEvent());
    });
  }

  final AuthBloc authBlock;
  late final StreamSubscription<AuthState> authBlockSubscription;

  void _onState(AuthState state) {
    if (state is AuthAuthorizedState) {
      emit(LoaderStates.auth);
    } else if (state is AuthUnauthorizedState) {
      emit(LoaderStates.notAuth);
    } else if (state is AuthFailState) {
      emit(LoaderStates.error);
    } else {
      emit(LoaderStates.unknown);
    }
  }

  @override
  Future<void> close() {
    authBlockSubscription.cancel();
    return super.close();
  }
}
