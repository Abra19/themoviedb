import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/entities/movies/movies.dart';
import 'package:the_movie_db/domain/entities/movies/popular_movie_response.dart';
import 'package:the_movie_db/domain/exceptions/api_client_exceptions.dart';
import 'package:the_movie_db/domain/exceptions/handle_errors.dart';
import 'package:the_movie_db/domain/services/movies_service.dart';
import 'package:the_movie_db/types/types.dart';

class TrendedViewModel extends ChangeNotifier {
  TrendedViewModel() {
    trendPeriod = periodValues[0];
  }

  final List<String> periodOptions = <String>['Today', 'Last week'];
  final List<String> periodValues = <String>['day', 'week'];
  List<bool> isSelectedDay = <bool>[true, false];
  late String trendPeriod;

  final ApiClient _apiClient = ApiClient();
  final MoviesService _movieService = MoviesService();

  final List<Movie> _trendedMovies = <Movie>[];
  List<Movie> get trendedMovies => List<Movie>.unmodifiable(_trendedMovies);

  bool _isTrendedLoaded = false;
  bool get isTrendedLoaded => _isTrendedLoaded;

  String _locale = 'ru';
  late DateFormat _dateFormat;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<DataStructure> makeDataStructure() =>
      _movieService.makeDataStructure(_trendedMovies, _dateFormat);

  Future<PopularMovieResponse?> _loadTrendingMovies(
    String trendPeriod,
    String locale,
  ) async {
    try {
      final PopularMovieResponse result =
          await _apiClient.getAllInTrend(trendPeriod, locale);
      return result;
    } on ApiClientException catch (error) {
      _errorMessage = handleErrors(error);
      return null;
    } catch (_) {
      _errorMessage = 'Unexpected error, try again later';
      return null;
    }
  }

  Future<void> _resetTrended() async {
    _trendedMovies.clear();

    final PopularMovieResponse? trendedResponse =
        await _loadTrendingMovies(trendPeriod, _locale);
    if (trendedResponse == null) {
      return;
    }
    _trendedMovies.addAll(trendedResponse.movies as Iterable<Movie>);
    _isTrendedLoaded = true;
    notifyListeners();
  }

  Future<void> setupLocale(BuildContext context) async {
    final String locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) {
      return;
    }
    _dateFormat = DateFormat.yMMMMd(locale);
    _locale = locale;
    await _resetTrended();
    notifyListeners();
  }

  Future<void> toggleSelectedPeriod(int index) async {
    isSelectedDay = isSelectedDay
        .asMap()
        .entries
        .map((MapEntry<int, bool> el) => el.key == index)
        .toList();
    trendPeriod = periodValues[index];
    await _resetTrended();
    notifyListeners();
  }
}
