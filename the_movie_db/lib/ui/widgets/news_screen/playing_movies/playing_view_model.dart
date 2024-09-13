import 'package:flutter/material.dart';

class PlayingMoviesViewModel extends ChangeNotifier {}


// NewsScreenViewModel() {
  //   trendPeriod = periodValues[0];
  //   regionValueComing = regionsValuesComing[0];
  //   regionValuePlaying = regionsValuesPlaying[0];
  // }
  // final List<String> periodOptions = <String>['Today', 'Last week'];
  // final List<String> periodValues = <String>['day', 'week'];
  // final List<String> regionOptions = <String>[
  //   'Russia',
  //   'Europe',
  //   'USA',
  // ];
  // final List<String> regionsValuesComing = <String>[
  //   'RU',
  //   'FR',
  //   'US',
  // ];
  // final List<String> regionsValuesPlaying = <String>[
  //   'RU',
  //   'FR',
  //   'US',
  // ];
  // late String trendPeriod;
  // late String regionValueComing;
  // late String regionValuePlaying;

  // final ApiClient _apiClient = ApiClient();

  // List<bool> isSelectedDay = <bool>[true, false];
  // List<bool> isSelectedRegionComing = <bool>[true, false, false];
  // List<bool> isSelectedRegionPlaying = <bool>[true, false, false];

  // final List<Movie> _trendedMovies = <Movie>[];
  // List<Movie> get trendedMovies => List<Movie>.unmodifiable(_trendedMovies);

  // bool _isTrendedLoaded = false;
  // bool get isTrendedLoaded => _isTrendedLoaded;

  // final List<Movie> _newMovies = <Movie>[];
  // List<Movie> get newMovies => List<Movie>.unmodifiable(_newMovies);

  // bool _isNewLoaded = false;
  // bool get isNewLoaded => _isNewLoaded;

  // final List<Movie> _playingMovies = <Movie>[];
  // List<Movie> get playingMovies => List<Movie>.unmodifiable(_playingMovies);

  // bool _isPlayingLoaded = false;
  // bool get isPlayingLoaded => _isTrendedLoaded;

  // String _locale = 'ru';
  // late DateFormat _dateFormat;

  // String? _errorMessage;
  // String? get errorMessage => _errorMessage;

  // String stringFromDate(DateTime? date) =>
  //     dateStringFromDate(_dateFormat, date);

  // Future<void> toggleSelectedPeriod(int index) async {
  //   isSelectedDay = isSelectedDay
  //       .asMap()
  //       .entries
  //       .map((MapEntry<int, bool> el) => el.key == index)
  //       .toList();
  //   trendPeriod = periodValues[index];
  //   await _resetTrended();

  //   notifyListeners();
  // }

  // List<bool> changeSelector(List<bool> current, int index) {
  //   return current
  //       .asMap()
  //       .entries
  //       .map((MapEntry<int, bool> el) => el.key == index)
  //       .toList();
  // }

  // Future<void> toggleSelectedRegion(int index, String selectedName) async {
  //   if (selectedName == 'Coming') {
  //     isSelectedRegionComing = changeSelector(isSelectedRegionComing, index);
  //     regionValueComing = regionsValuesComing[index];
  //   } else {
  //     isSelectedRegionPlaying = changeSelector(isSelectedRegionPlaying, index);
  //     regionValuePlaying = regionsValuesPlaying[index];
  //   }

  //   await _resetList();

  //   notifyListeners();
  // }

  // Future<PopularMovieResponse> _loadTrendingMovies(
  //   String trendPeriod,
  //   String locale,
  // ) async {
  //   return _apiClient.getAllInTrend(trendPeriod, locale);
  // }

  // Future<PopularMovieResponse> _loadNewMovies(
  //   String regionValue,
  //   String locale,
  // ) async {
  //   return _apiClient.getNewMovies(regionValue, locale);
  // }

  // Future<PopularMovieResponse> _loadNewShows(
  //   String regionValue,
  //   String locale,
  // ) async {
  //   return _apiClient.getNewShows(regionValue, locale);
  // }

  // Future<PopularMovieResponse> _loadPlayingMovies(
  //   String regionValue,
  //   String locale,
  // ) async {
  //   return _apiClient.getPlayingMovies(regionValue, locale);
  // }

  // Future<PopularMovieResponse> _loadPlayingShows(
  //   String regionValue,
  //   String locale,
  // ) async {
  //   return _apiClient.getPlayingShows(regionValue, locale);
  // }

  // Future<void> _resetTrended() async {
  //   _trendedMovies.clear();

  //   final PopularMovieResponse trendedResponse =
  //       await _loadTrendingMovies(trendPeriod, _locale);
  //   _trendedMovies.addAll(trendedResponse.movies as Iterable<Movie>);
  //   _isTrendedLoaded = true;
  //   notifyListeners();
  // }

  // Future<void> _resetList() async {
  //   _trendedMovies.clear();
  //   _newMovies.clear();
  //   _playingMovies.clear();

  //   final PopularMovieResponse trendedResponse =
  //       await _loadTrendingMovies(trendPeriod, _locale);
  //   _trendedMovies.addAll(trendedResponse.movies as Iterable<Movie>);

  //   final PopularMovieResponse newMoviesResponse =
  //       await _loadNewMovies(regionValueComing, _locale);
  //   for (final Movie movie in newMoviesResponse.movies) {
  //     movie.mediaType = movie.mediaType ?? (movie.mediaType = 'movie');
  //   }
  //   _newMovies.addAll(newMoviesResponse.movies as Iterable<Movie>);

  //   final PopularMovieResponse newShowsResponse =
  //       await _loadNewShows(regionValueComing, _locale);
  //   for (final Movie movie in newShowsResponse.movies) {
  //     movie.mediaType = movie.mediaType ?? (movie.mediaType = 'tv');
  //   }
  //   _newMovies.addAll(newShowsResponse.movies as Iterable<Movie>);

  //   final PopularMovieResponse playingMoviesResponse =
  //       await _loadPlayingMovies(regionValuePlaying, _locale);
  //   for (final Movie movie in playingMoviesResponse.movies) {
  //     movie.mediaType = movie.mediaType ?? (movie.mediaType = 'movie');
  //   }
  //   _playingMovies.addAll(playingMoviesResponse.movies as Iterable<Movie>);

  //   final PopularMovieResponse playingShowsResponse =
  //       await _loadPlayingShows(regionValuePlaying, _locale);
  //   for (final Movie movie in playingShowsResponse.movies) {
  //     movie.mediaType = movie.mediaType ?? (movie.mediaType = 'tv');
  //   }
  //   _playingMovies.addAll(playingShowsResponse.movies as Iterable<Movie>);
  //   _isLoaded = true;
  //   notifyListeners();
  // }

  // Future<void> setupLocale(BuildContext context) async {
  //   final String locale = Localizations.localeOf(context).toLanguageTag();
  //   if (_locale == locale) {
  //     return;
  //   }
  //   _dateFormat = DateFormat.yMMMMd(locale);
  //   _locale = locale;
  //   await _resetList();
  //   notifyListeners();
  // }

