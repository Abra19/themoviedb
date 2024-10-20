// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:the_movie_db/domain/blocs/shows_list_bloc.dart';
import 'package:the_movie_db/domain/events/shows_events.dart';
import 'package:the_movie_db/domain/server_entities/movies/movies.dart';
import 'package:the_movie_db/domain/states/shows_state.dart';
import 'package:the_movie_db/library/make_row_data/make_row_data.dart';
import 'package:the_movie_db/types/types.dart';

class ShowListCubitState {
  ShowListCubitState({
    required this.shows,
    required this.localTag,
  });

  final List<MovieListRowData> shows;
  final String localTag;

  @override
  bool operator ==(covariant ShowListCubitState other) {
    if (identical(this, other)) {
      return true;
    }

    return listEquals(other.shows, shows) && other.localTag == localTag;
  }

  @override
  int get hashCode {
    return shows.hashCode ^ localTag.hashCode;
  }

  ShowListCubitState copyWith({
    List<MovieListRowData>? shows,
    String? localTag,
  }) {
    return ShowListCubitState(
      shows: shows ?? this.shows,
      localTag: localTag ?? this.localTag,
    );
  }
}

class ShowListCubit extends Cubit<ShowListCubitState> {
  final ShowsListBloc showBloc;
  late final StreamSubscription<ShowsListState> showBlockSubscription;
  late DateFormat _dateFormat;
  Timer? _searchDebounce;
  String errorMessage = '';

  ShowListCubit({
    required this.showBloc,
  }) : super(
          ShowListCubitState(
            shows: const <MovieListRowData>[],
            localTag: '',
          ),
        ) {
    Future<void>.microtask(() {
      _onState(showBloc.state);
      showBlockSubscription = showBloc.stream.listen(_onState);
    });
  }

  void _onState(ShowsListState state) {
    final List<MovieListRowData> shows = state.shows.map((Movie show) {
      show.mediaType = 'tv';
      return HandleRowData.makeRowData(show, _dateFormat);
    }).toList();
    final ShowListCubitState newState = this.state.copyWith(
          shows: shows,
        );
    emit(newState);
  }

  void setupLocale(String localeTag) {
    if (state.localTag == localeTag) {
      return;
    }
    final ShowListCubitState newState = state.copyWith(localTag: localeTag);
    emit(newState);
    _dateFormat = DateFormat.yMMMMd(localeTag);
    showBloc.add(ShowsListReset());
    showBloc.add(ShowsListLoadNextPage(locale: localeTag));
  }

  void showShowAtIndex(int index) {
    if (index < state.shows.length - 1) {
      return;
    }
    showBloc.add(ShowsListLoadNextPage(locale: state.localTag));
  }

  Future<void> searchShows(String query) async {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 100), () async {
      showBloc.add(ShowsListSearch(query: query));
      showBloc.add(ShowsListLoadNextPage(locale: state.localTag));
    });
  }

  @override
  Future<void> close() {
    showBlockSubscription.cancel();
    return super.close();
  }
}
