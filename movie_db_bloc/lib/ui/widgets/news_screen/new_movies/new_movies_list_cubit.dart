// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'package:the_movie_db/constants/region_enum.dart';
import 'package:the_movie_db/domain/blocs/new_movies_bloc.dart';
import 'package:the_movie_db/domain/events/new_movies_events.dart';
import 'package:the_movie_db/domain/server_entities/movies/movies.dart';
import 'package:the_movie_db/domain/states/new_movies_state.dart';
import 'package:the_movie_db/library/make_row_data/make_row_data.dart';
import 'package:the_movie_db/types/types.dart';

class NewMoviesListCubitState {
  NewMoviesListCubitState({
    required this.newMoviesList,
    required this.localTag,
    required this.selectedRegion,
  });

  final List<MovieListRowData> newMoviesList;
  final String localTag;
  final String selectedRegion;
  final String errorMessage = '';

  NewMoviesListCubitState copyWith({
    List<MovieListRowData>? newMoviesList,
    String? localTag,
    String? selectedRegion,
    bool? isLoading,
  }) {
    return NewMoviesListCubitState(
      newMoviesList: newMoviesList ?? this.newMoviesList,
      localTag: localTag ?? this.localTag,
      selectedRegion: selectedRegion ?? this.selectedRegion,
    );
  }

  @override
  bool operator ==(covariant NewMoviesListCubitState other) {
    if (identical(this, other)) {
      return true;
    }

    return listEquals(other.newMoviesList, newMoviesList) &&
        other.localTag == localTag &&
        other.selectedRegion == selectedRegion;
  }

  @override
  int get hashCode {
    return newMoviesList.hashCode ^ localTag.hashCode ^ selectedRegion.hashCode;
  }
}

class NewMoviesListCubit extends Cubit<NewMoviesListCubitState> {
  NewMoviesListCubit({
    required this.newMoviesListsBloc,
  }) : super(
          NewMoviesListCubitState(
            newMoviesList: const <MovieListRowData>[],
            localTag: '',
            selectedRegion: RegionType.ru.name,
          ),
        ) {
    Future<void>.microtask(() {
      _onState(newMoviesListsBloc.state);
      newMoviesListsBlockSubscription =
          newMoviesListsBloc.stream.listen(_onState);
    });
  }
  final NewMoviesListBloc newMoviesListsBloc;
  late final StreamSubscription<NewMoviesListsState>
      newMoviesListsBlockSubscription;
  late DateFormat dateFormat;

  String errorMessage = '';
  final List<String> regionOptions = <String>[
    'Russia',
    'Europe',
    'USA',
  ];

  void _onState(NewMoviesListsState state) {
    final List<MovieListRowData> movies = state.movies
        .map((Movie movie) => HandleRowData.makeRowData(movie, dateFormat))
        .toList();
    final List<MovieListRowData> shows = state.shows
        .map((Movie show) => HandleRowData.makeRowData(show, dateFormat))
        .toList();
    final NewMoviesListCubitState newState = this.state.copyWith(
      newMoviesList: <MovieListRowData>[...movies, ...shows],
      selectedRegion: state.selectedRegion,
    );
    emit(newState);
  }

  void rebase(String localeTag) {
    newMoviesListsBloc.add(NewMoviesLoad(locale: localeTag));
    newMoviesListsBloc.add(NewShowsLoad(locale: localeTag));
  }

  void setupLocale(String localeTag) {
    if (state.localTag == localeTag) {
      return;
    }
    final NewMoviesListCubitState newState =
        state.copyWith(localTag: localeTag);
    emit(newState);
    dateFormat = DateFormat.yMMMMd(localeTag);

    newMoviesListsBloc.add(NewMoviesListReset());
    rebase(localeTag);
  }

  Future<void> toggleSelectedRegion(int index) async {
    switch (index) {
      case 0:
        emit(state.copyWith(selectedRegion: RegionType.ru.name));
        newMoviesListsBloc.add(NewMoviesListReset());
        newMoviesListsBloc
            .add(NewMoviesRegionChange(region: RegionType.ru.name));
      case 1:
        emit(state.copyWith(selectedRegion: RegionType.eu.name));
        newMoviesListsBloc.add(NewMoviesListReset());
        newMoviesListsBloc
            .add(NewMoviesRegionChange(region: RegionType.eu.name));
      case 2:
        emit(state.copyWith(selectedRegion: RegionType.us.name));
        newMoviesListsBloc.add(NewMoviesListReset());
        newMoviesListsBloc
            .add(NewMoviesRegionChange(region: RegionType.us.name));
    }
    rebase(state.localTag);
  }

  @override
  Future<void> close() {
    newMoviesListsBlockSubscription.cancel();
    return super.close();
  }
}
