import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:the_movie_db/constants/errors_text.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/events/trended_events.dart';
import 'package:the_movie_db/domain/exceptions/api_client_exceptions.dart';
import 'package:the_movie_db/domain/exceptions/handle_errors.dart';
import 'package:the_movie_db/domain/server_entities/movies/popular_movie_response.dart';
import 'package:the_movie_db/domain/states/trended_state.dart';

class TrendedListBloc extends Bloc<TrendedListEvents, TrendedListsState> {
  TrendedListBloc(super.initialState) {
    on<TrendedListEvents>(
      (TrendedListEvents event, Emitter<TrendedListsState> emit) async {
        if (event is TrendedMoviesLoad) {
          await onTrendedMoviesLoad(event, emit);
        } else if (event is TrendedListReset) {
          await onTrendedListReset(event, emit);
        } else if (event is TrendedPeriodChange) {
          emit(state.copyWith(selectedPeriod: event.period));
        }
      },
      transformer: sequential(),
    );
  }

  final ApiClient _apiClient = ApiClient();

  Future<void> onTrendedMoviesLoad(
    TrendedMoviesLoad event,
    Emitter<TrendedListsState> emit,
  ) async {
    try {
      final PopularMovieResponse result =
          await _apiClient.getAllInTrend(state.selectedPeriod, event.locale);
      final TrendedListsState newState = state.copyWith(
        trendedMovies: result,
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

  Future<void> onTrendedListReset(
    TrendedListReset event,
    Emitter<TrendedListsState> emit,
  ) async {
    emit(TrendedListsState.init());
  }
}
