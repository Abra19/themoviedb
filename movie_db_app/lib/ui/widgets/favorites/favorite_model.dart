import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/data_providers/local_storage.dart';
import 'package:the_movie_db/domain/server_entities/movies/popular_movie_response.dart';
import 'package:the_movie_db/domain/server_entities/movies/movies.dart';
import 'package:the_movie_db/domain/services/movies_service.dart';
import 'package:the_movie_db/library/paginators/paginatator.dart';
import 'package:the_movie_db/types/types.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class FavoriteViewModel extends ChangeNotifier {
  FavoriteViewModel() {
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

  final MoviesService _moviesService = MoviesService();
  late final Paginator<Movie> _favoriteMoviesPaginator;
  late final Paginator<Movie> _favoriteShowsPaginator;
  final LocalStorage _localeStorage = LocalStorage();

  Timer? searchDebounce;

  final List<MovieListRowData> _favorites = <MovieListRowData>[];
  List<MovieListRowData> get favorites =>
      List<MovieListRowData>.unmodifiable(_favorites);

  late DateFormat _dateFormat;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> _loadFavoriteMoviesNextPage() async {
    _errorMessage = await _favoriteMoviesPaginator.loadNextPage();
    final List<MovieListRowData> movies =
        _favoriteMoviesPaginator.entities.map((Movie movie) {
      movie.mediaType = 'movie';
      return _moviesService.makeRowData(movie, _dateFormat);
    }).toList();

    _favorites.addAll(movies as Iterable<MovieListRowData>);

    notifyListeners();
  }

  Future<void> _loadFavoriteShowsNextPage() async {
    _errorMessage = await _favoriteShowsPaginator.loadNextPage();
    final List<MovieListRowData> shows =
        _favoriteShowsPaginator.entities.map((Movie movie) {
      movie.mediaType = 'tv';
      return _moviesService.makeRowData(movie, _dateFormat);
    }).toList();

    _favorites.addAll(shows as Iterable<MovieListRowData>);

    notifyListeners();
  }

  Future<void> _loadFavoritesNextPage() async {
    _loadFavoriteMoviesNextPage();
    _loadFavoriteShowsNextPage();
    notifyListeners();
  }

  void showFavoriteAtIndex(int index) {
    if (index < favorites.length - 1) {
      return;
    }
    _loadFavoritesNextPage();
    notifyListeners();
  }

  Future<void> _resetList() async {
    final String? moviesError = await _favoriteMoviesPaginator.reset();
    final String? showsError = await _favoriteShowsPaginator.reset();
    _errorMessage = moviesError ?? showsError;
    _favorites.clear();

    await _loadFavoritesNextPage();
    notifyListeners();
  }

  Future<void> setupLocale(Locale locale) async {
    final bool updateLocale = _localeStorage.updateLocale(locale);
    if (!updateLocale) {
      return;
    }
    _dateFormat = DateFormat.yMMMMd(_localeStorage.localeTag);
    await _resetList();
    notifyListeners();
  }

  Future<void> onFavoriteClick(
    BuildContext context,
    int id,
    String type,
  ) async {
    if (type == 'tv') {
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
