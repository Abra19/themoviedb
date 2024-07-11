import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/entities/popular_movie_response.dart';

import 'package:the_movie_db/domain/entities/movies.dart';
import 'package:the_movie_db/domain/exceptions/api_client_exceptions.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class MoviesWidgetModel extends ChangeNotifier {
  final ApiClient _apiClient = ApiClient();

  final List<Movie> _movies = <Movie>[];
  List<Movie> get movies => List<Movie>.unmodifiable(_movies);

  String _locale = 'ru';
  late DateFormat _dateFormat;

  late int _currentPage;
  late int _totalPages;
  bool _isLoadingInProgress = false;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _searchQuery;

  Timer? searchDebounce;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  Future<PopularMovieResponse> _loadMovies(int page, String locale) async {
    final String? query = _searchQuery;
    if (query == null) {
      return _apiClient.popularMovie(page, _locale);
    }
    return _apiClient.searchMovie(page, locale, query);
  }

  Future<void> _loadMoviesNextPage() async {
    if (_currentPage >= _totalPages || _isLoadingInProgress) {
      return;
    }
    _isLoadingInProgress = true;
    final int nextPage = _currentPage + 1;
    try {
      final PopularMovieResponse response =
          await _loadMovies(nextPage, _locale);
      _currentPage = response.page;
      _totalPages = response.totalPages;
      _movies.addAll(response.movies! as Iterable<Movie>);
    } on ApiClientException catch (error) {
      switch (error.type) {
        case ApiClientExceptionType.network:
          _errorMessage = 'No internet connection';
        default:
          _errorMessage = 'Something went wrong, try again later';
      }
    } catch (_) {
      _errorMessage = 'Unexpected error, try again later';
    } finally {
      notifyListeners();
      _isLoadingInProgress = false;
    }
  }

  void showMovieAtIndex(int index) {
    if (index < _movies.length - 1) {
      return;
    }
    _loadMoviesNextPage();
  }

  Future<void> _resetList() async {
    _currentPage = 0;
    _totalPages = 1;
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

  Future<void> onRetryClick() async {
    _errorMessage = null;
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
      final String? searchQuery = query.isNotEmpty ? query : null;
      if (_searchQuery == searchQuery) {
        return;
      }
      _searchQuery = searchQuery;
      await _resetList();
    });
  }
}
