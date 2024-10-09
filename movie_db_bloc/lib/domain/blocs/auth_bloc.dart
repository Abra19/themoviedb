import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/data_providers/session_data_provider.dart';
import 'package:the_movie_db/domain/events/auth_events.dart';
import 'package:the_movie_db/domain/states/auth_state.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  AuthBloc(super.initialState) {
    on<AuthEvents>(
      (AuthEvents event, Emitter<AuthState> emit) async {
        if (event is CheckAuthEvent) {
          await _onCheckAuthEvent(event, emit);
        } else if (event is LoginEvent) {
          await _onLoginEvent(event, emit);
        } else if (event is LogoutEvent) {
          await _onLogoutEvent(event, emit);
        }
      },
      transformer: sequential(),
    );

    add(CheckAuthEvent());
  }

  final SessionDataProvider _sessionDataProvider = SessionDataProvider();
  final ApiClient _apiClient = ApiClient();

  Future<void> _onCheckAuthEvent(
    CheckAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthProcessState());
      final String? sessionId = await _sessionDataProvider.getSessionId();
      final AuthState newState =
          sessionId != null ? AuthAuthorizedState() : AuthUnauthorizedState();
      emit(newState);
    } catch (e) {
      emit(AuthFailState(e));
    }
  }

  Future<void> _onLoginEvent(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final String sessionId = await _apiClient.auth(
        username: event.login,
        password: event.password,
      );
      await _sessionDataProvider.setSessionId(sessionId);
      emit(AuthAuthorizedState());
    } catch (e) {
      emit(AuthFailState(e));
    }
  }

  Future<void> _onLogoutEvent(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _sessionDataProvider.clearStorage();
      emit(AuthUnauthorizedState());
    } catch (e) {
      emit(AuthFailState(e));
    }
  }
}
