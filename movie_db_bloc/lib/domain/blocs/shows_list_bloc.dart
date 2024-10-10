import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_db/constants/errors_text.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/events/shows_events.dart';
import 'package:the_movie_db/domain/exceptions/api_client_exceptions.dart';
import 'package:the_movie_db/domain/exceptions/handle_errors.dart';
import 'package:the_movie_db/domain/server_entities/movies/popular_movie_response.dart';
import 'package:the_movie_db/domain/states/shows_state.dart';
import 'package:the_movie_db/library/page_loader/page_loader.dart';
import 'package:the_movie_db/types/types.dart';

class ShowsListBloc extends Bloc<ShowsListEvents, ShowsListState> {
  ShowsListBloc(super.initialState) {
    on<ShowsListEvents>(
      (ShowsListEvents event, Emitter<ShowsListState> emit) async {
        if (event is ShowsListLoadNextPage) {
          await onShowsListLoadNextPage(event, emit);
        } else if (event is ShowsListReset) {
          await onShowsListReset(event, emit);
        } else if (event is ShowsListSearch) {
          await onShowsListSearch(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  final ApiClient _apiClient = ApiClient();

  Future<void> onShowsListLoadNextPage(
    ShowsListLoadNextPage event,
    Emitter<ShowsListState> emit,
  ) async {
    if (state.isSearchMode) {
      try {
        final MoviesContainer? newContainer = await PageLoader.loadNextPage(
            state.searchShowsContainer, (int page) async {
          final PopularMovieResponse result = await _apiClient.searchTV(
            page,
            event.locale,
            state.searchQuery,
          );
          return result;
        });
        if (newContainer != null) {
          final ShowsListState newState = state.copyWith(
            searchShowsContainer: newContainer,
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
    } else {
      try {
        final MoviesContainer? newContainer = await PageLoader.loadNextPage(
            state.popularShowsContainer, (int page) async {
          final PopularMovieResponse result = await _apiClient.popularShows(
            page,
            event.locale,
          );
          return result;
        });
        if (newContainer != null) {
          final ShowsListState newState = state.copyWith(
            popularShowsContainer: newContainer,
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
  }

  Future<void> onShowsListReset(
    ShowsListReset event,
    Emitter<ShowsListState> emit,
  ) async {
    emit(ShowsListState.init());
  }

  Future<void> onShowsListSearch(
    ShowsListSearch event,
    Emitter<ShowsListState> emit,
  ) async {
    if (state.searchQuery == event.query) {
      return;
    }

    final ShowsListState newState = state.copyWith(
      searchQuery: event.query,
      searchShowsContainer: const MoviesContainer.init(),
    );
    emit(newState);
  }
}
