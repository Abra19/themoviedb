import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/entities/shows/popular_shows_response.dart';
import 'package:the_movie_db/domain/entities/shows/shows.dart';
import 'package:the_movie_db/domain/exceptions/api_client_exceptions.dart';
import 'package:the_movie_db/domain/exceptions/handle_errors.dart';
import 'package:the_movie_db/library/dates/date_string_from_date.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class TVShowsViewModel extends ChangeNotifier {
  final ApiClient _apiClient = ApiClient();

  final List<TVShow> _shows = <TVShow>[];
  List<TVShow> get shows => List<TVShow>.unmodifiable(_shows);

  String _locale = 'ru';
  late DateFormat _dateFormat;

  late int _currentPage;
  late int _totalPages;
  bool _isLoadingInProgress = false;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _searchQuery;

  Timer? searchDebounce;

  // String stringFromDate(DateTime? date) =>
  //     dateStringFromDate(_dateFormat, date);

  Future<PopularTVShowsResponse> _loadShows(int page, String locale) async {
    final String? query = _searchQuery;
    if (query == null) {
      return _apiClient.popularShows(page, _locale);
    }
    return _apiClient.searchTV(page, locale, query);
  }

  Future<void> _loadShowsNextPage() async {
    if (_currentPage >= _totalPages || _isLoadingInProgress) {
      return;
    }
    _isLoadingInProgress = true;
    final int nextPage = _currentPage + 1;
    try {
      final PopularTVShowsResponse response =
          await _loadShows(nextPage, _locale);
      _currentPage = response.page;
      _totalPages = response.totalPages;
      _shows.addAll(response.shows! as Iterable<TVShow>);
    } on ApiClientException catch (error) {
      _errorMessage = handleErrors(error);
    } catch (_) {
      _errorMessage = 'Unexpected error, try again later';
    } finally {
      notifyListeners();
      _isLoadingInProgress = false;
    }
  }

  void showAtIndex(int index) {
    if (index < _shows.length - 1) {
      return;
    }
    _loadShowsNextPage();
  }

  Future<void> _resetList() async {
    _currentPage = 0;
    _totalPages = 1;
    _shows.clear();
    await _loadShowsNextPage();
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

  void onShowClick(BuildContext context, int index) {
    final int id = _shows[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.tvDetails,
      arguments: id,
    );
  }

  Future<void> searchShows(String query) async {
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
