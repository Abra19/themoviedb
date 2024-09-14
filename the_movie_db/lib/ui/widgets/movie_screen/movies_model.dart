import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/entities/movies/popular_movie_response.dart';
import 'package:the_movie_db/domain/entities/movies/movies.dart';
import 'package:the_movie_db/domain/services/movies_service.dart';
import 'package:the_movie_db/library/paginators/paginatator.dart';
import 'package:the_movie_db/types/types.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class MoviesViewModel extends ChangeNotifier {
  MoviesViewModel() {
    _popularMoviesPaginator = Paginator<Movie>((int page) async {
      final PopularMovieResponse result =
          await _moviesService.getPopularMovies(page, _locale);
      return PaginatorLoadResult<Movie>(
        entities: result.movies,
        currentPage: result.page,
        totalPages: result.totalPages,
      );
    });
    _searchMoviesPaginator = Paginator<Movie>((int page) async {
      final PopularMovieResponse result =
          await _moviesService.searchMovies(page, _locale, _searchQuery);
      return PaginatorLoadResult<Movie>(
        entities: result.movies,
        currentPage: result.page,
        totalPages: result.totalPages,
      );
    });
  }
  final MoviesService _moviesService = MoviesService();
  late final Paginator<Movie> _popularMoviesPaginator;
  late final Paginator<Movie> _searchMoviesPaginator;

  String _locale = 'ru';
  Timer? searchDebounce;

  List<MovieListRowData> _movies = <MovieListRowData>[];
  List<MovieListRowData> get movies =>
      List<MovieListRowData>.unmodifiable(_movies);

  late DateFormat _dateFormat;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  bool isSearchMode() => _searchQuery.isNotEmpty;

  Future<void> _loadMoviesNextPage() async {
    if (isSearchMode()) {
      _errorMessage = await _searchMoviesPaginator.loadNextPage();
      _movies = _searchMoviesPaginator.entities
          .map((Movie movie) => _moviesService.makeRowData(movie, _dateFormat))
          .toList();
    } else {
      _errorMessage = await _popularMoviesPaginator.loadNextPage();
      _movies = _popularMoviesPaginator.entities
          .map((Movie movie) => _moviesService.makeRowData(movie, _dateFormat))
          .toList();
    }
    notifyListeners();
  }

  void showMovieAtIndex(int index) {
    if (index < _movies.length - 1) {
      return;
    }
    _loadMoviesNextPage();
  }

  Future<void> _resetList() async {
    final String? popularError = await _popularMoviesPaginator.reset();
    final String? searchError = await _searchMoviesPaginator.reset();
    _errorMessage = popularError ?? searchError;
    _movies.clear();

    await _loadMoviesNextPage();
  }

  Future<void> setupLocale(BuildContext context) async {
    final String locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) {
      return;
    }
    _dateFormat = DateFormat.yMMMMd(locale);
    _locale = locale;
    await _resetList();
    notifyListeners();
  }

  void onMovieClick(BuildContext context, int index) {
    final int id = _movies[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetails,
      arguments: id,
    );
  }

  Future<void> searchMovies(String query) async {
    searchDebounce?.cancel();
    searchDebounce = Timer(const Duration(milliseconds: 100), () async {
      final String searchQuery = query.isNotEmpty ? query : '';
      if (_searchQuery == searchQuery) {
        return;
      }
      _searchQuery = searchQuery;
      if (isSearchMode()) {
        _errorMessage = await _searchMoviesPaginator.reset();
      }
      _loadMoviesNextPage();
    });
  }
}
