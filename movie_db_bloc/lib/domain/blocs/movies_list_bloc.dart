import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_db/constants/errors_text.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/events/movies_events.dart';
import 'package:the_movie_db/domain/exceptions/api_client_exceptions.dart';
import 'package:the_movie_db/domain/exceptions/handle_errors.dart';
import 'package:the_movie_db/domain/server_entities/movies/movies.dart';
import 'package:the_movie_db/domain/server_entities/movies/popular_movie_response.dart';
import 'package:the_movie_db/domain/states/movies_state.dart';

class MoviesListBloc extends Bloc<MoviesListEvents, MoviesListState> {
  MoviesListBloc(super.initialState) {
    on<MoviesListEvents>(
      (MoviesListEvents event, Emitter<MoviesListState> emit) async {
        if (event is MoviesListLoadNextPage) {
          await onMoviesListLoadNextPage(event, emit);
        } else if (event is MoviesListReset) {
          await onMoviesListReset(event, emit);
        } else if (event is MoviesListSearch) {
          await onMoviesListSearch(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  final ApiClient _apiClient = ApiClient();

  Future<MoviesContainer?> _loadNextPage(
    MoviesContainer moviesContainer,
    Future<PopularMovieResponse> Function(int) loader,
  ) async {
    if (moviesContainer.isComplete) {
      return null;
    }
    final int nextPage = moviesContainer.currentPage + 1;

    final PopularMovieResponse result = await loader(nextPage);
    final List<Movie> movies = List<Movie>.from(moviesContainer.movies)
      ..addAll(result.movies);
    final MoviesContainer container = moviesContainer.copyWith(
      movies: movies,
      currentPage: result.page,
      totalPages: result.totalPages,
    );
    return container;
  }

  Future<void> onMoviesListLoadNextPage(
    MoviesListLoadNextPage event,
    Emitter<MoviesListState> emit,
  ) async {
    if (state.isSearchMode) {
      try {
        final MoviesContainer? newContainer =
            await _loadNextPage(state.searchMoviesContainer, (int page) async {
          final PopularMovieResponse result = await _apiClient.searchMovie(
            page,
            event.locale,
            state.searchQuery,
          );
          return result;
        });
        if (newContainer != null) {
          final MoviesListState newState = state.copyWith(
            searchMoviesContainer: newContainer,
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
        final MoviesContainer? newContainer =
            await _loadNextPage(state.popularMoviesContainer, (int page) async {
          final PopularMovieResponse result = await _apiClient.popularMovie(
            page,
            event.locale,
          );
          return result;
        });
        if (newContainer != null) {
          final MoviesListState newState = state.copyWith(
            popularMoviesContainer: newContainer,
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

  Future<void> onMoviesListReset(
    MoviesListReset event,
    Emitter<MoviesListState> emit,
  ) async {
    emit(MoviesListState.init());
  }

  Future<void> onMoviesListSearch(
    MoviesListSearch event,
    Emitter<MoviesListState> emit,
  ) async {
    if (state.searchQuery == event.query) {
      return;
    }

    final MoviesListState newState = state.copyWith(
      searchQuery: event.query,
      searchMoviesContainer: const MoviesContainer.init(),
    );
    emit(newState);
  }
}
