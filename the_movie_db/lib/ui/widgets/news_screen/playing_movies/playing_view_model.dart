import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/entities/movies/movies.dart';
import 'package:the_movie_db/domain/entities/movies/popular_movie_response.dart';
import 'package:the_movie_db/domain/exceptions/api_client_exceptions.dart';
import 'package:the_movie_db/domain/exceptions/handle_errors.dart';
import 'package:the_movie_db/domain/services/movies_service.dart';
import 'package:the_movie_db/types/types.dart';

class PlayingMoviesViewModel extends ChangeNotifier {
  PlayingMoviesViewModel() {
    regionValue = regionsValues[0];
  }

  late String regionValue;
  final List<String> regionOptions = <String>[
    'Russia',
    'Europe',
    'USA',
  ];
  final List<String> regionsValues = <String>[
    'RU',
    'FR',
    'US',
  ];

  List<bool> isSelectedRegion = <bool>[true, false, false];

  final ApiClient _apiClient = ApiClient();
  final MoviesService _movieService = MoviesService();

  final List<Movie> _playingMovies = <Movie>[];
  List<Movie> get playingMovies => List<Movie>.unmodifiable(_playingMovies);

  bool _isPlayingLoaded = false;
  bool get isPlayingLoaded => _isPlayingLoaded;

  String _locale = 'ru';
  late DateFormat _dateFormat;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<DataStructure> makeDataStructure() =>
      _movieService.makeDataStructure(_playingMovies, _dateFormat);

  Future<PopularMovieResponse?> _loadPlayingMovies(
    String regionValue,
    String locale,
  ) async {
    try {
      final PopularMovieResponse result =
          await _apiClient.getPlayingMovies(regionValue, locale);
      return result;
    } on ApiClientException catch (error) {
      _errorMessage = handleErrors(error);
      return null;
    } catch (_) {
      _errorMessage = 'Unexpected error, try again later';
      return null;
    }
  }

  Future<PopularMovieResponse?> _loadPlayingShows(
    String regionValue,
    String locale,
  ) async {
    try {
      final PopularMovieResponse result =
          await _apiClient.getPlayingShows(regionValue, locale);
      return result;
    } on ApiClientException catch (error) {
      _errorMessage = handleErrors(error);
      return null;
    } catch (_) {
      _errorMessage = 'Unexpected error, try again later';
      return null;
    }
  }

  Future<void> _resetPlaying() async {
    _playingMovies.clear();

    final PopularMovieResponse? playingMoviesResponse =
        await _loadPlayingMovies(regionValue, _locale);

    final PopularMovieResponse? playingShowsResponse =
        await _loadPlayingShows(regionValue, _locale);

    if (playingMoviesResponse == null || playingShowsResponse == null) {
      return;
    }

    for (final Movie movie in playingMoviesResponse.movies) {
      movie.mediaType = movie.mediaType ?? (movie.mediaType = 'movie');
    }
    for (final Movie movie in playingShowsResponse.movies) {
      movie.mediaType = movie.mediaType ?? (movie.mediaType = 'tv');
    }

    _playingMovies.addAll(playingMoviesResponse.movies as Iterable<Movie>);
    _playingMovies.addAll(playingShowsResponse.movies as Iterable<Movie>);

    _isPlayingLoaded = true;
    notifyListeners();
  }

  Future<void> setupLocale(BuildContext context) async {
    final String locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) {
      return;
    }
    _dateFormat = DateFormat.yMMMMd(locale);
    _locale = locale;
    await _resetPlaying();
    notifyListeners();
  }

  Future<void> toggleSelectedRegion(int index) async {
    isSelectedRegion = _movieService.changeSelector(isSelectedRegion, index);
    regionValue = regionsValues[index];

    await _resetPlaying();
    notifyListeners();
  }
}
