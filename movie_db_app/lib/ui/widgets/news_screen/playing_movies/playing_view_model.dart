import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/data_providers/local_storage.dart';
import 'package:the_movie_db/domain/server_entities/movies/movies.dart';
import 'package:the_movie_db/domain/server_entities/movies/popular_movie_response.dart';
import 'package:the_movie_db/domain/exceptions/api_client_exceptions.dart';
import 'package:the_movie_db/domain/exceptions/handle_errors.dart';
import 'package:the_movie_db/domain/services/movies_service.dart';
import 'package:the_movie_db/types/types.dart';

class PlayingMoviesViewModel extends ChangeNotifier {
  PlayingMoviesViewModel({
    required this.apiClient,
    required this.movieService,
  }) {
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

  final ApiClientFactory apiClient;
  final MoviesService movieService;

  final List<Movie> _playingMovies = <Movie>[];
  List<Movie> get playingMovies => List<Movie>.unmodifiable(_playingMovies);

  bool _isPlayingLoaded = false;
  bool get isPlayingLoaded => _isPlayingLoaded;

  final LocalStorage _localeStorage = LocalStorage();
  late DateFormat _dateFormat;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<DataStructure> makeDataStructure() =>
      movieService.makeDataStructure(_playingMovies, _dateFormat);

  Future<PopularMovieResponse?> _loadPlayingMovies(
    String regionValue,
    String locale,
  ) async {
    try {
      final PopularMovieResponse result =
          await apiClient.getPlayingMovies(regionValue, locale);
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
          await apiClient.getPlayingShows(regionValue, locale);
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
        await _loadPlayingMovies(regionValue, _localeStorage.localeTag);

    final PopularMovieResponse? playingShowsResponse =
        await _loadPlayingShows(regionValue, _localeStorage.localeTag);

    if (playingMoviesResponse == null || playingShowsResponse == null) {
      return;
    }

    for (final Movie movie in playingMoviesResponse.movies) {
      movie.mediaType = 'movie';
    }
    for (final Movie movie in playingShowsResponse.movies) {
      movie.mediaType = 'tv';
    }

    _playingMovies.addAll(playingMoviesResponse.movies as Iterable<Movie>);
    _playingMovies.addAll(playingShowsResponse.movies as Iterable<Movie>);

    _isPlayingLoaded = true;
    notifyListeners();
  }

  Future<void> setupLocale(Locale locale) async {
    final bool updateLocale = _localeStorage.updateLocale(locale);
    if (!updateLocale) {
      return;
    }
    _dateFormat = DateFormat.yMMMMd(_localeStorage.localeTag);
    await _resetPlaying();
    notifyListeners();
  }

  Future<void> toggleSelectedRegion(int index) async {
    isSelectedRegion = movieService.changeSelector(isSelectedRegion, index);
    regionValue = regionsValues[index];

    await _resetPlaying();
    notifyListeners();
  }
}
