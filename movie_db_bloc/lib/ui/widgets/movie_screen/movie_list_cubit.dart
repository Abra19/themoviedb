// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:the_movie_db/domain/blocs/movies_list_bloc.dart';
import 'package:the_movie_db/domain/events/movies_events.dart';
import 'package:the_movie_db/domain/server_entities/movies/movies.dart';
import 'package:the_movie_db/domain/states/movies_state.dart';
import 'package:the_movie_db/library/make_row_data/make_row_data.dart';
import 'package:the_movie_db/types/types.dart';

class MovieListCubitState {
  MovieListCubitState({
    required this.movies,
    required this.localTag,
  });

  final List<MovieListRowData> movies;
  final String localTag;

  @override
  bool operator ==(covariant MovieListCubitState other) {
    if (identical(this, other)) {
      return true;
    }

    return listEquals(other.movies, movies) && other.localTag == localTag;
  }

  @override
  int get hashCode {
    return movies.hashCode ^ localTag.hashCode;
  }

  MovieListCubitState copyWith({
    List<MovieListRowData>? movies,
    String? localTag,
  }) {
    return MovieListCubitState(
      movies: movies ?? this.movies,
      localTag: localTag ?? this.localTag,
    );
  }
}

class MovieListCubit extends Cubit<MovieListCubitState> {
  final MoviesListBloc movieBloc;
  late final StreamSubscription<MoviesListState> movieBlockSubscription;
  late DateFormat _dateFormat;
  Timer? _searchDebounce;
  String errorMessage = '';

  MovieListCubit({
    required this.movieBloc,
  }) : super(
          MovieListCubitState(
            movies: const <MovieListRowData>[],
            localTag: '',
          ),
        ) {
    Future<void>.microtask(() {
      _onState(movieBloc.state);
      movieBlockSubscription = movieBloc.stream.listen(_onState);
    });
  }

  void _onState(MoviesListState state) {
    final List<MovieListRowData> movies = state.movies.map((Movie movie) {
      movie.mediaType = 'movie';
      return HandleRowData.makeRowData(movie, _dateFormat);
    }).toList();
    final MovieListCubitState newState = this.state.copyWith(
          movies: movies,
        );
    emit(newState);
  }

  void setupLocale(String localeTag) {
    if (state.localTag == localeTag) {
      return;
    }
    final MovieListCubitState newState = state.copyWith(localTag: localeTag);
    emit(newState);
    _dateFormat = DateFormat.yMMMMd(localeTag);
    movieBloc.add(MoviesListReset());
    movieBloc.add(MoviesListLoadNextPage(locale: localeTag));
  }

  void showMovieAtIndex(int index) {
    if (index < state.movies.length - 1) {
      return;
    }
    movieBloc.add(MoviesListLoadNextPage(locale: state.localTag));
  }

  Future<void> searchMovies(String query) async {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 100), () async {
      movieBloc.add(MoviesListSearch(query: query));
      movieBloc.add(MoviesListLoadNextPage(locale: state.localTag));
    });
  }

  @override
  Future<void> close() {
    movieBlockSubscription.cancel();
    return super.close();
  }
}
