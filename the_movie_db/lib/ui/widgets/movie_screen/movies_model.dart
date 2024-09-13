import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/entities/movies/popular_movie_response.dart';
import 'package:the_movie_db/domain/entities/movies/movies.dart';
import 'package:the_movie_db/domain/services/movies_service.dart';
import 'package:the_movie_db/library/dates/date_string_from_date.dart';
import 'package:the_movie_db/library/paginators/paginatator.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class MovieListRowData {
  MovieListRowData({
    required this.id,
    required this.title,
    required this.name,
    required this.posterPath,
    required this.releaseDate,
    required this.overview,
  });

  final int id;
  final String? title;
  final String? name;
  final String? posterPath;
  final String? releaseDate;
  final String? overview;
}

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

  MovieListRowData _makeRowData(Movie movie) {
    final DateTime? date = movie.releaseDate;
    final String? releaseDate =
        date != null ? stringFromDate(date, _dateFormat) : null;
    return MovieListRowData(
      id: movie.id,
      title: movie.title,
      name: movie.name,
      posterPath: movie.posterPath,
      releaseDate: releaseDate,
      overview: movie.overview,
    );
  }

  bool isSearchMode() => _searchQuery.isNotEmpty;

  Future<void> _loadMoviesNextPage() async {
    if (isSearchMode()) {
      _errorMessage = await _searchMoviesPaginator.loadMoviesNextPage();
      _movies = _searchMoviesPaginator.entities.map(_makeRowData).toList();
    } else {
      _errorMessage = await _popularMoviesPaginator.loadMoviesNextPage();
      _movies = _popularMoviesPaginator.entities.map(_makeRowData).toList();
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
    searchDebounce = Timer(const Duration(milliseconds: 250), () async {
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
