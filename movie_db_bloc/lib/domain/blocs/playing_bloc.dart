import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:the_movie_db/constants/errors_text.dart';
import 'package:the_movie_db/constants/media_type_enum.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/events/playing_events.dart';
import 'package:the_movie_db/domain/exceptions/api_client_exceptions.dart';
import 'package:the_movie_db/domain/exceptions/handle_errors.dart';
import 'package:the_movie_db/domain/server_entities/movies/movies.dart';
import 'package:the_movie_db/domain/server_entities/movies/popular_movie_response.dart';
import 'package:the_movie_db/domain/states/playing_state.dart';

class PlayingListBloc extends Bloc<PlayingListEvents, PlayingListsState> {
  PlayingListBloc(super.initialState) {
    on<PlayingListEvents>(
      (PlayingListEvents event, Emitter<PlayingListsState> emit) async {
        if (event is PlayingMoviesLoad) {
          await onPlayingMoviesLoad(event, emit);
        } else if (event is PlayingShowsLoad) {
          await onPlayingShowsLoad(event, emit);
        } else if (event is PlayingListReset) {
          await onPlayingListReset(event, emit);
        } else if (event is PlayingRegionChange) {
          emit(state.copyWith(selectedRegion: event.region));
        }
      },
      transformer: sequential(),
    );
  }

  final ApiClient _apiClient = ApiClient();

  Future<void> onPlayingMoviesLoad(
    PlayingMoviesLoad event,
    Emitter<PlayingListsState> emit,
  ) async {
    try {
      final PopularMovieResponse result =
          await _apiClient.getPlayingMovies(state.selectedRegion, event.locale);
      for (final Movie el in result.movies) {
        el.mediaType = MediaType.movie.name;
      }
      final PlayingListsState newState = state.copyWith(
        playingMovies: result,
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

  Future<void> onPlayingShowsLoad(
    PlayingShowsLoad event,
    Emitter<PlayingListsState> emit,
  ) async {
    try {
      final PopularMovieResponse result =
          await _apiClient.getPlayingShows(state.selectedRegion, event.locale);
      for (final Movie el in result.movies) {
        el.mediaType = MediaType.tv.name;
      }
      final PlayingListsState newState = state.copyWith(
        playingShows: result,
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

  Future<void> onPlayingListReset(
    PlayingListReset event,
    Emitter<PlayingListsState> emit,
  ) async {
    emit(PlayingListsState.init());
  }
}
