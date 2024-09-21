import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/constants/media_type_enum.dart';
import 'package:the_movie_db/domain/data_providers/local_storage.dart';
import 'package:the_movie_db/domain/server_entities/movies/popular_movie_response.dart';
import 'package:the_movie_db/domain/server_entities/movies/movies.dart';
import 'package:the_movie_db/domain/services/movies_service.dart';
import 'package:the_movie_db/library/paginators/paginatator.dart';
import 'package:the_movie_db/types/types.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class FavoriteViewModel extends ChangeNotifier {
  FavoriteViewModel() {
    selectedType = MediaType.movie.name;
    _favoriteMoviesPaginator = Paginator<Movie>((int page) async {
      final PopularMovieResponse? result = await _moviesService
          .getFavoriteMovies(page: page, locale: _localeStorage.localeTag);

      return PaginatorLoadResult<Movie>(
        entities: result?.movies ?? <Movie>[],
        currentPage: result?.page ?? 0,
        totalPages: result?.totalPages ?? 1,
      );
    });
    _favoriteShowsPaginator = Paginator<Movie>((int page) async {
      final PopularMovieResponse? result = await _moviesService
          .getFavoriteShows(page: page, locale: _localeStorage.localeTag);

      return PaginatorLoadResult<Movie>(
        entities: result?.movies ?? <Movie>[],
        currentPage: result?.page ?? 0,
        totalPages: result?.totalPages ?? 1,
      );
    });
  }

  final List<String> favoritesOptions = <String>[
    'Movies',
    'TV Shows',
  ];

  List<bool> isSelectedFavorites = <bool>[true, false];
  late String selectedType;

  final MoviesService _moviesService = MoviesService();
  late final Paginator<Movie> _favoriteMoviesPaginator;
  late final Paginator<Movie> _favoriteShowsPaginator;
  final LocalStorage _localeStorage = LocalStorage();

  List<MovieListRowData> _favorites = <MovieListRowData>[];
  List<MovieListRowData> get favorites => _favorites;

  late DateFormat _dateFormat;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> _loadFavoriteMoviesNextPage() async {
    _errorMessage = await _favoriteMoviesPaginator.loadNextPage();
    _favorites = _favoriteMoviesPaginator.entities.map((Movie movie) {
      movie.mediaType = MediaType.movie.name;
      return _moviesService.makeRowData(movie, _dateFormat);
    }).toList();

    notifyListeners();
  }

  Future<void> _loadFavoriteShowsNextPage() async {
    _errorMessage = await _favoriteShowsPaginator.loadNextPage();
    _favorites = _favoriteShowsPaginator.entities.map((Movie movie) {
      movie.mediaType = MediaType.tv.name;
      return _moviesService.makeRowData(movie, _dateFormat);
    }).toList();

    notifyListeners();
  }

  Future<void> loaderByType(String type) async {
    if (type == MediaType.movie.name) {
      await _loadFavoriteMoviesNextPage();
    } else {
      await _loadFavoriteShowsNextPage();
    }
  }

  Future<void> showFavoritesAtIndex(int index) async {
    if (index < _favorites.length - 1) {
      return;
    }
    loaderByType(selectedType);
  }

  Future<void> resetList() async {
    _errorMessage = selectedType == MediaType.movie.name
        ? await _favoriteMoviesPaginator.reset()
        : await _favoriteShowsPaginator.reset();

    _favorites.clear();
    loaderByType(selectedType);

    notifyListeners();
  }

  Future<void> setupLocale(Locale locale) async {
    final bool updateLocale = _localeStorage.updateLocale(locale);
    if (!updateLocale) {
      return;
    }
    _dateFormat = DateFormat.yMMMMd(_localeStorage.localeTag);
    await resetList();
    notifyListeners();
  }

  Future<void> toggleSelectedFavorites(int index) async {
    final List<String> favoritesTypes = <String>[
      MediaType.movie.name,
      MediaType.tv.name,
    ];
    isSelectedFavorites = isSelectedFavorites
        .asMap()
        .entries
        .map((MapEntry<int, bool> el) => el.key == index)
        .toList();
    selectedType = favoritesTypes[index];
    await resetList();
    notifyListeners();
  }

  Future<void> onFavoriteClick(
    BuildContext context,
    int id,
    String type,
  ) async {
    if (type == MediaType.tv.name) {
      Navigator.of(context).pushNamed(
        MainNavigationRouteNames.tvDetails,
        arguments: id,
      );
    } else {
      Navigator.of(context).pushNamed(
        MainNavigationRouteNames.movieDetails,
        arguments: id,
      );
    }
  }
}
