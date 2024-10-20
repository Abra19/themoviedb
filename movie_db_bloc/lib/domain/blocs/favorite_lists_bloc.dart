import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_db/constants/errors_text.dart';
import 'package:the_movie_db/constants/media_type_enum.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/data_providers/session_data_provider.dart';
import 'package:the_movie_db/domain/events/favorite_events.dart';
import 'package:the_movie_db/domain/exceptions/api_client_exceptions.dart';
import 'package:the_movie_db/domain/exceptions/handle_errors.dart';
import 'package:the_movie_db/domain/server_entities/movies/popular_movie_response.dart';

import 'package:the_movie_db/domain/states/favorites_state.dart';
import 'package:the_movie_db/library/page_loader/page_loader.dart';
import 'package:the_movie_db/types/types.dart';

class FavoriteListsBloc extends Bloc<FavoriteListEvents, FavoriteListsState> {
  FavoriteListsBloc(super.initialState) {
    on<FavoriteListEvents>(
      (FavoriteListEvents event, Emitter<FavoriteListsState> emit) async {
        if (event is FavoriteMoviesLoadNextPage) {
          await onFavoriteMoviesLoadNextPage(event, emit);
        } else if (event is FavoriteShowsLoadNextPage) {
          await onFavoriteShowsLoadNextPage(event, emit);
        } else if (event is FavoritesListReset) {
          await onFavoriteListReset(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  final ApiClient _apiClient = ApiClient();
  final SessionDataProvider _sessionProvider = SessionDataProvider();

  Future<void> onFavoriteMoviesLoadNextPage(
    FavoriteMoviesLoadNextPage event,
    Emitter<FavoriteListsState> emit,
  ) async {
    try {
      final String? token = await _sessionProvider.getSessionId();
      if (token == null) {
        emit(state.copyWith(errorMessage: sessionExpiredText));
        return;
      }
      final MoviesContainer? newContainer = await PageLoader.loadNextPage(
          state.favoritesMovieContainer, (int page) async {
        final PopularMovieResponse result = await _apiClient.getFavoriteMovies(
          event.locale,
          page,
          token,
        );
        return result;
      });
      if (newContainer != null) {
        final FavoriteListsState newState = state.copyWith(
          favoritesMovieContainer: newContainer,
          selectedType: MediaType.movie.name,
        );
        emit(newState);
      }
    } on ApiClientException catch (error) {
      final String errorMessage = handleErrors(error);
      emit(state.copyWith(errorMessage: errorMessage));
    } catch (_) {
      const String errorMessage = unexpectedErrorText;
      emit(state.copyWith(errorMessage: errorMessage));
    }
  }

  Future<void> onFavoriteShowsLoadNextPage(
    FavoriteShowsLoadNextPage event,
    Emitter<FavoriteListsState> emit,
  ) async {
    try {
      final String? token = await _sessionProvider.getSessionId();
      if (token == null) {
        emit(state.copyWith(errorMessage: sessionExpiredText));
        return;
      }
      final MoviesContainer? newContainer = await PageLoader.loadNextPage(
          state.favoritesMovieContainer, (int page) async {
        final PopularMovieResponse result = await _apiClient.getFavoriteShows(
          event.locale,
          page,
          token,
        );
        return result;
      });
      if (newContainer != null) {
        final FavoriteListsState newState = state.copyWith(
          favoritesMovieContainer: newContainer,
          selectedType: MediaType.tv.name,
        );
        emit(newState);
      }
    } on ApiClientException catch (error) {
      final String errorMessage = handleErrors(error);
      emit(state.copyWith(errorMessage: errorMessage));
    } catch (_) {
      const String errorMessage = unexpectedErrorText;
      emit(state.copyWith(errorMessage: errorMessage));
    }
  }

  Future<void> onFavoriteListReset(
    FavoritesListReset event,
    Emitter<FavoriteListsState> emit,
  ) async {
    emit(FavoriteListsState.init());
  }
}
