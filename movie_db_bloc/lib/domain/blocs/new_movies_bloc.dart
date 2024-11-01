import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:the_movie_db/constants/errors_text.dart';
import 'package:the_movie_db/constants/media_type_enum.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/events/new_movies_events.dart';
import 'package:the_movie_db/domain/exceptions/api_client_exceptions.dart';
import 'package:the_movie_db/domain/exceptions/handle_errors.dart';
import 'package:the_movie_db/domain/server_entities/movies/movies.dart';
import 'package:the_movie_db/domain/server_entities/movies/popular_movie_response.dart';
import 'package:the_movie_db/domain/states/new_movies_state.dart';

class NewMoviesListBloc extends Bloc<NewMoviesListEvents, NewMoviesListsState> {
  NewMoviesListBloc(super.initialState) {
    on<NewMoviesListEvents>(
      (NewMoviesListEvents event, Emitter<NewMoviesListsState> emit) async {
        if (event is NewMoviesLoad) {
          await onNewMoviesLoad(event, emit);
        } else if (event is NewShowsLoad) {
          await onNewShowsLoad(event, emit);
        } else if (event is NewMoviesListReset) {
          await onNewMoviesListReset(event, emit);
        } else if (event is NewMoviesRegionChange) {
          emit(state.copyWith(selectedRegion: event.region));
        }
      },
      transformer: sequential(),
    );
  }

  final ApiClient _apiClient = ApiClient();

  Future<void> onNewMoviesLoad(
    NewMoviesLoad event,
    Emitter<NewMoviesListsState> emit,
  ) async {
    try {
      final PopularMovieResponse result =
          await _apiClient.getNewMovies(state.selectedRegion, event.locale);
      for (final Movie el in result.movies) {
        el.mediaType = MediaType.movie.name;
      }
      final NewMoviesListsState newState = state.copyWith(
        newMovies: result,
      );
      emit(newState);
    } on ApiClientException catch (error) {
      final String errorMessage = handleErrors(error);
      emit(state.copyWith(errorMessage: errorMessage));
    } catch (_) {
      const String errorMessage = unexpectedErrorText;
      emit(state.copyWith(errorMessage: errorMessage));
    }
  }

  Future<void> onNewShowsLoad(
    NewShowsLoad event,
    Emitter<NewMoviesListsState> emit,
  ) async {
    try {
      final PopularMovieResponse result =
          await _apiClient.getNewShows(state.selectedRegion, event.locale);
      for (final Movie el in result.movies) {
        el.mediaType = MediaType.tv.name;
      }
      final NewMoviesListsState newState = state.copyWith(
        newShows: result,
      );
      emit(newState);
    } on ApiClientException catch (error) {
      final String errorMessage = handleErrors(error);
      emit(state.copyWith(errorMessage: errorMessage));
    } catch (_) {
      const String errorMessage = unexpectedErrorText;
      emit(state.copyWith(errorMessage: errorMessage));
    }
  }

  Future<void> onNewMoviesListReset(
    NewMoviesListReset event,
    Emitter<NewMoviesListsState> emit,
  ) async {
    emit(NewMoviesListsState.init());
  }
}
