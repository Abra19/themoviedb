// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/constants/media_type_enum.dart';

import 'package:the_movie_db/domain/blocs/favorite_lists_bloc.dart';
import 'package:the_movie_db/domain/events/favorite_events.dart';
import 'package:the_movie_db/domain/server_entities/movies/movies.dart';
import 'package:the_movie_db/domain/states/favorites_state.dart';
import 'package:the_movie_db/library/make_row_data/make_row_data.dart';
import 'package:the_movie_db/types/types.dart';

class FavoriteListCubitState {
  FavoriteListCubitState({
    required this.favorites,
    required this.localTag,
    required this.selectedType,
  });

  final List<MovieListRowData> favorites;
  final String localTag;
  final String selectedType;

  FavoriteListCubitState copyWith({
    List<MovieListRowData>? favorites,
    String? localTag,
    String? selectedType,
  }) {
    return FavoriteListCubitState(
      favorites: favorites ?? this.favorites,
      localTag: localTag ?? this.localTag,
      selectedType: selectedType ?? this.selectedType,
    );
  }

  @override
  bool operator ==(covariant FavoriteListCubitState other) {
    if (identical(this, other)) {
      return true;
    }

    return listEquals(other.favorites, favorites) &&
        other.localTag == localTag &&
        other.selectedType == selectedType;
  }

  @override
  int get hashCode =>
      favorites.hashCode ^ localTag.hashCode ^ selectedType.hashCode;
}

class FavoriteListCubit extends Cubit<FavoriteListCubitState> {
  final FavoriteListsBloc favoritesBloc;
  late final StreamSubscription<FavoriteListsState> favoritesBlockSubscription;
  late DateFormat _dateFormat;

  String errorMessage = '';
  final List<String> favoritesOptions = <String>[
    'Movies',
    'TV Shows',
  ];

  FavoriteListCubit({
    required this.favoritesBloc,
  }) : super(
          FavoriteListCubitState(
            favorites: const <MovieListRowData>[],
            localTag: '',
            selectedType: MediaType.movie.name,
          ),
        ) {
    Future<void>.microtask(() {
      _onState(favoritesBloc.state);
      favoritesBlockSubscription = favoritesBloc.stream.listen(_onState);
    });
  }

  void _onState(FavoriteListsState state) {
    final List<MovieListRowData> movies = state.movies.map((Movie movie) {
      movie.mediaType = state.selectedType;
      return HandleRowData.makeRowData(movie, _dateFormat);
    }).toList();
    final FavoriteListCubitState newState = this.state.copyWith(
          favorites: movies,
          selectedType: MediaType.movie.name,
        );
    emit(newState);
  }

  void setupLocale(String localeTag) {
    if (state.localTag == localeTag) {
      return;
    }
    final FavoriteListCubitState newState = state.copyWith(localTag: localeTag);
    emit(newState);
    _dateFormat = DateFormat.yMMMMd(localeTag);
    favoritesBloc.add(FavoritesListReset());
    state.selectedType == MediaType.movie.name
        ? favoritesBloc.add(FavoriteMoviesLoadNextPage(locale: localeTag))
        : favoritesBloc.add(FavoriteShowsLoadNextPage(locale: localeTag));
  }

  Future<void> toggleSelectedFavorites(int index) async {
    if (index == 0) {
      emit(state.copyWith(selectedType: MediaType.movie.name));
      favoritesBloc.add(FavoritesListReset());
      favoritesBloc.add(FavoriteMoviesLoadNextPage(locale: state.localTag));
    } else {
      emit(state.copyWith(selectedType: MediaType.tv.name));
      favoritesBloc.add(FavoritesListReset());
      favoritesBloc.add(FavoriteShowsLoadNextPage(locale: state.localTag));
    }
  }

  Future<void> showFavoritesAtIndex(int index) async {
    if (index < state.favorites.length - 1) {
      return;
    }
    state.selectedType == MediaType.movie.name
        ? favoritesBloc.add(FavoriteMoviesLoadNextPage(locale: state.localTag))
        : favoritesBloc.add(FavoriteShowsLoadNextPage(locale: state.localTag));
  }

  @override
  Future<void> close() {
    favoritesBlockSubscription.cancel();
    return super.close();
  }
}
