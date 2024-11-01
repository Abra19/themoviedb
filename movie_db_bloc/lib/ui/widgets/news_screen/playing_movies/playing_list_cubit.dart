// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:the_movie_db/constants/region_enum.dart';
import 'package:the_movie_db/domain/blocs/playing_bloc.dart';
import 'package:the_movie_db/domain/events/playing_events.dart';
import 'package:the_movie_db/domain/server_entities/movies/movies.dart';
import 'package:the_movie_db/domain/states/playing_state.dart';
import 'package:the_movie_db/library/make_row_data/make_row_data.dart';
import 'package:the_movie_db/types/types.dart';

class PlayingListCubitState {
  PlayingListCubitState({
    required this.playingList,
    required this.localTag,
    required this.selectedRegion,
  });

  final List<MovieListRowData> playingList;
  final String localTag;
  final String selectedRegion;
  final String errorMessage = '';

  PlayingListCubitState copyWith({
    List<MovieListRowData>? playingList,
    String? localTag,
    String? selectedRegion,
    bool? isLoading,
  }) {
    return PlayingListCubitState(
      playingList: playingList ?? this.playingList,
      localTag: localTag ?? this.localTag,
      selectedRegion: selectedRegion ?? this.selectedRegion,
    );
  }

  @override
  bool operator ==(covariant PlayingListCubitState other) {
    if (identical(this, other)) {
      return true;
    }

    return listEquals(other.playingList, playingList) &&
        other.localTag == localTag &&
        other.selectedRegion == selectedRegion;
  }

  @override
  int get hashCode {
    return playingList.hashCode ^ localTag.hashCode ^ selectedRegion.hashCode;
  }
}

class PlayingListCubit extends Cubit<PlayingListCubitState> {
  final PlayingListBloc playingListsBloc;
  late final StreamSubscription<PlayingListsState>
      playingListsBlockSubscription;
  late DateFormat dateFormat;

  String errorMessage = '';
  final List<String> regionOptions = <String>[
    'Russia',
    'Europe',
    'USA',
  ];

  PlayingListCubit({
    required this.playingListsBloc,
  }) : super(
          PlayingListCubitState(
            playingList: const <MovieListRowData>[],
            localTag: '',
            selectedRegion: RegionType.ru.name,
          ),
        ) {
    Future<void>.microtask(() {
      _onState(playingListsBloc.state);
      playingListsBlockSubscription = playingListsBloc.stream.listen(_onState);
    });
  }

  void _onState(PlayingListsState state) {
    final List<MovieListRowData> movies = state.movies
        .map((Movie movie) => HandleRowData.makeRowData(movie, dateFormat))
        .toList();
    final List<MovieListRowData> shows = state.shows
        .map((Movie show) => HandleRowData.makeRowData(show, dateFormat))
        .toList();
    final PlayingListCubitState newState = this.state.copyWith(
      playingList: <MovieListRowData>[...movies, ...shows],
      selectedRegion: state.selectedRegion,
    );
    emit(newState);
  }

  void rebase(String localeTag) {
    playingListsBloc.add(PlayingMoviesLoad(locale: localeTag));
    playingListsBloc.add(PlayingShowsLoad(locale: localeTag));
  }

  void setupLocale(String localeTag) {
    if (state.localTag == localeTag) {
      return;
    }
    final PlayingListCubitState newState = state.copyWith(localTag: localeTag);
    emit(newState);
    dateFormat = DateFormat.yMMMMd(localeTag);

    playingListsBloc.add(PlayingListReset());
    rebase(localeTag);
  }

  Future<void> toggleSelectedRegion(int index) async {
    switch (index) {
      case 0:
        emit(state.copyWith(selectedRegion: RegionType.ru.name));
        playingListsBloc.add(PlayingListReset());
        playingListsBloc.add(PlayingRegionChange(region: RegionType.ru.name));
      case 1:
        emit(state.copyWith(selectedRegion: RegionType.eu.name));
        playingListsBloc.add(PlayingListReset());
        playingListsBloc.add(PlayingRegionChange(region: RegionType.eu.name));
      case 2:
        emit(state.copyWith(selectedRegion: RegionType.us.name));
        playingListsBloc.add(PlayingListReset());
        playingListsBloc.add(PlayingRegionChange(region: RegionType.us.name));
    }
    rebase(state.localTag);
  }

  @override
  Future<void> close() {
    playingListsBlockSubscription.cancel();
    return super.close();
  }
}
