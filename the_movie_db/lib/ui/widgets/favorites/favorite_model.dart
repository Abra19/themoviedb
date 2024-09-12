import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/data_providers/session_data_provider.dart';
import 'package:the_movie_db/domain/entities/movies/popular_movie_response.dart';

import 'package:the_movie_db/domain/entities/movies/movies.dart';
import 'package:the_movie_db/domain/exceptions/api_client_exceptions.dart';
import 'package:the_movie_db/library/dates/date_string_from_date.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class FavoriteViewModel extends ChangeNotifier {
  final SessionDataProvider sessionProvider = SessionDataProvider();
  final ApiClient _apiClient = ApiClient();

  final List<Movie> _movies = <Movie>[];
  List<Movie> get movies => List<Movie>.unmodifiable(_movies);

  final List<Movie> _favorites = <Movie>[];
  List<Movie> get favorites => List<Movie>.unmodifiable(_favorites);

  String _locale = 'ru';
  late DateFormat _dateFormat;

  late int _currentPage;
  late int _totalPages;
  bool _isLoadingInProgress = false;

  late int _currentPageMoviesFavorite;
  late int _totalPagesMoviesFavorite;

  late int _currentPageShowsFavorite;
  late int _totalPagesShowsFavorite;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _searchQuery;

  Timer? searchDebounce;

  String stringFromDate(DateTime? date) =>
      dateStringFromDate(_dateFormat, date);

  Future<PopularMovieResponse> _loadMovies(int page, String locale) async {
    final String? query = _searchQuery;
    if (query == null) {
      return _apiClient.popularMovie(page, _locale);
    }
    return _apiClient.searchMovie(page, locale, query);
  }

  Future<PopularMovieResponse?> _loadFavoritesMovies(
    int page,
    String locale,
  ) async {
    final String? token = await sessionProvider.getSessionId();
    if (token == null) {
      return null; // logout
    }

    return _apiClient.getFavoriteMovies(_locale, page, token);
  }

  Future<PopularMovieResponse?> _loadFavoritesShows(
    int page,
    String locale,
  ) async {
    final String? token = await sessionProvider.getSessionId();
    if (token == null) {
      return null; // logout
    }

    return _apiClient.getFavoriteShows(_locale, page, token);
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

  Future<void> _loadFavoritesMoviesNextPage() async {
    if (_currentPageMoviesFavorite >= _totalPagesMoviesFavorite ||
        _isLoadingInProgress) {
      return;
    }
    _isLoadingInProgress = true;
    final int nextPage = _currentPageMoviesFavorite + 1;

    try {
      final PopularMovieResponse? movieResponse =
          await _loadFavoritesMovies(nextPage, _locale);
      if (movieResponse == null) {
        return;
      }
      for (final Movie movie in movieResponse.movies!) {
        movie.mediaType = movie.mediaType ?? (movie.mediaType = 'movie');
      }
      _currentPageMoviesFavorite = movieResponse.page;
      _totalPagesMoviesFavorite = movieResponse.totalPages;
      _favorites.addAll(movieResponse.movies! as Iterable<Movie>);
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

  Future<void> _loadFavoritesShowsNextPage() async {
    if (_currentPageShowsFavorite >= _totalPagesShowsFavorite ||
        _isLoadingInProgress) {
      return;
    }
    _isLoadingInProgress = true;
    final int nextPage = _currentPageShowsFavorite + 1;
    try {
      final PopularMovieResponse? showResponse =
          await _loadFavoritesShows(nextPage, _locale);
      if (showResponse == null) {
        return;
      }
      for (final Movie show in showResponse.movies!) {
        show.mediaType = show.mediaType ?? (show.mediaType = 'tv');
      }
      _currentPageShowsFavorite = showResponse.page;
      _totalPagesShowsFavorite = showResponse.totalPages;
      _favorites.addAll(showResponse.movies! as Iterable<Movie>);
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

  void showFavoriteAtIndex(int index) {
    if (index < _favorites.length - 1) {
      return;
    }
    _loadFavoritesMoviesNextPage();
    _loadFavoritesShowsNextPage();
  }

  Future<void> _resetList() async {
    _currentPage = 0;
    _currentPageMoviesFavorite = 0;
    _currentPageShowsFavorite = 0;
    _totalPages = 1;
    _totalPagesMoviesFavorite = 1;
    _totalPagesShowsFavorite = 1;
    _movies.clear();
    _favorites.clear();
    await _loadMoviesNextPage();
    await _loadFavoritesMoviesNextPage();
    await _loadFavoritesShowsNextPage();
  }

  Future<void> get resetList => _resetList();

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
      final String? searchQuery = query.isNotEmpty ? query : null;
      if (_searchQuery == searchQuery) {
        return;
      }
      _searchQuery = searchQuery;
      await _resetList();
    });
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
