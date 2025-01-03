import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/data_providers/local_storage.dart';
import 'package:the_movie_db/domain/server_entities/movies/movies.dart';
import 'package:the_movie_db/domain/server_entities/movies/popular_movie_response.dart';
import 'package:the_movie_db/domain/services/movies_service.dart';
import 'package:the_movie_db/library/paginators/paginatator.dart';
import 'package:the_movie_db/types/types.dart';
import 'package:the_movie_db/ui/navigation/main_navigation_routes.dart';

class TVShowsViewModel extends ChangeNotifier {
  TVShowsViewModel(this.moviesService) {
    _popularShowPaginator = Paginator<Movie>((int page) async {
      final PopularMovieResponse result =
          await moviesService.getPopularShows(page, _localeStorage.localeTag);
      return PaginatorLoadResult<Movie>(
        entities: result.movies,
        currentPage: result.page,
        totalPages: result.totalPages,
      );
    });
    _searchShowPaginator = Paginator<Movie>((int page) async {
      final PopularMovieResponse result = await moviesService.searchShows(
        page,
        _localeStorage.localeTag,
        _searchQuery,
      );
      return PaginatorLoadResult<Movie>(
        entities: result.movies,
        currentPage: result.page,
        totalPages: result.totalPages,
      );
    });
  }

  final MoviesService moviesService;
  late final Paginator<Movie> _popularShowPaginator;
  late final Paginator<Movie> _searchShowPaginator;

  final LocalStorage _localeStorage = LocalStorage();
  Timer? searchDebounce;

  List<MovieListRowData> _shows = <MovieListRowData>[];
  List<MovieListRowData> get shows =>
      List<MovieListRowData>.unmodifiable(_shows);

  late DateFormat _dateFormat;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  bool isSearchMode() => _searchQuery.isNotEmpty;

  Future<void> _loadShowsNextPage() async {
    if (isSearchMode()) {
      _errorMessage = await _searchShowPaginator.loadNextPage();
      _shows = _searchShowPaginator.entities.map((Movie movie) {
        movie.mediaType = 'tv';
        return moviesService.makeRowData(movie, _dateFormat);
      }).toList();
    } else {
      _errorMessage = await _popularShowPaginator.loadNextPage();
      _shows = _popularShowPaginator.entities.map((Movie movie) {
        movie.mediaType = 'tv';
        return moviesService.makeRowData(movie, _dateFormat);
      }).toList();
    }
    notifyListeners();
  }

  void showShowAtIndex(int index) {
    if (index < _shows.length - 1) {
      return;
    }
    _loadShowsNextPage();
  }

  Future<void> _resetList() async {
    final String? popularError = await _popularShowPaginator.reset();
    final String? searchError = await _searchShowPaginator.reset();
    _errorMessage = popularError ?? searchError;
    _shows.clear();

    await _loadShowsNextPage();
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

  void onShowClick(BuildContext context, int index) {
    final int id = _shows[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.tvDetails,
      arguments: id,
    );
  }

  Future<void> searchShows(String query) async {
    searchDebounce?.cancel();
    searchDebounce = Timer(const Duration(milliseconds: 100), () async {
      final String searchQuery = query.isNotEmpty ? query : '';
      if (_searchQuery == searchQuery) {
        return;
      }
      _searchQuery = searchQuery;
      if (isSearchMode()) {
        _errorMessage = await _searchShowPaginator.reset();
      }
      _loadShowsNextPage();
    });
  }
}
