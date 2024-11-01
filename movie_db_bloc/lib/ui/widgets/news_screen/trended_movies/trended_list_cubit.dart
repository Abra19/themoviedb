// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'package:the_movie_db/constants/period_enum.dart';
import 'package:the_movie_db/domain/blocs/trended_bloc.dart';
import 'package:the_movie_db/domain/events/trended_events.dart';
import 'package:the_movie_db/domain/server_entities/movies/movies.dart';
import 'package:the_movie_db/domain/states/trended_state.dart';
import 'package:the_movie_db/library/make_row_data/make_row_data.dart';
import 'package:the_movie_db/types/types.dart';

class TrendedListCubitState {
  TrendedListCubitState({
    required this.trendedList,
    required this.localTag,
    required this.selectedPeriod,
  });

  final List<MovieListRowData> trendedList;
  final String localTag;
  final String selectedPeriod;
  final String errorMessage = '';

  TrendedListCubitState copyWith({
    List<MovieListRowData>? trendedList,
    String? localTag,
    String? selectedPeriod,
  }) {
    return TrendedListCubitState(
      trendedList: trendedList ?? this.trendedList,
      localTag: localTag ?? this.localTag,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
    );
  }

  @override
  bool operator ==(covariant TrendedListCubitState other) {
    if (identical(this, other)) {
      return true;
    }

    return listEquals(other.trendedList, trendedList) &&
        other.localTag == localTag &&
        other.selectedPeriod == selectedPeriod;
  }

  @override
  int get hashCode =>
      trendedList.hashCode ^ localTag.hashCode ^ selectedPeriod.hashCode;
}

class TrendedListCubit extends Cubit<TrendedListCubitState> {
  final TrendedListBloc trendedListsBloc;
  late final StreamSubscription<TrendedListsState>
      trendedListsBlockSubscription;
  late DateFormat dateFormat;

  String errorMessage = '';
  final List<String> periodOptions = <String>[
    'Today',
    'Last week',
  ];

  TrendedListCubit({
    required this.trendedListsBloc,
  }) : super(
          TrendedListCubitState(
            trendedList: const <MovieListRowData>[],
            localTag: '',
            selectedPeriod: PeriodType.day.name,
          ),
        ) {
    Future<void>.microtask(() {
      _onState(trendedListsBloc.state);
      trendedListsBlockSubscription = trendedListsBloc.stream.listen(_onState);
    });
  }

  void _onState(TrendedListsState state) {
    final List<MovieListRowData> movies = state.movies
        .map((Movie movie) => HandleRowData.makeRowData(movie, dateFormat))
        .toList();

    final TrendedListCubitState newState = this.state.copyWith(
          trendedList: movies,
          selectedPeriod: state.selectedPeriod,
        );
    emit(newState);
  }

  void setupLocale(String localeTag) {
    if (state.localTag == localeTag) {
      return;
    }
    final TrendedListCubitState newState = state.copyWith(localTag: localeTag);
    emit(newState);
    dateFormat = DateFormat.yMMMMd(localeTag);

    trendedListsBloc.add(TrendedListReset());
    trendedListsBloc.add(TrendedMoviesLoad(locale: localeTag));
  }

  Future<void> toggleSelectedPeriod(int index) async {
    switch (index) {
      case 0:
        emit(state.copyWith(selectedPeriod: PeriodType.day.name));
        trendedListsBloc.add(TrendedListReset());
        trendedListsBloc.add(TrendedPeriodChange(period: PeriodType.day.name));
      case 1:
        emit(state.copyWith(selectedPeriod: PeriodType.week.name));
        trendedListsBloc.add(TrendedListReset());
        trendedListsBloc.add(TrendedPeriodChange(period: PeriodType.week.name));
    }
    trendedListsBloc.add(TrendedMoviesLoad(locale: state.localTag));
  }

  @override
  Future<void> close() {
    trendedListsBlockSubscription.cancel();
    return super.close();
  }
}
