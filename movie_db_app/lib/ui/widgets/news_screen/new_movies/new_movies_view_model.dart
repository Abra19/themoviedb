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

class NewMoviesViewModel extends ChangeNotifier {
  NewMoviesViewModel() {
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

  final List<Movie> _newMovies = <Movie>[];
  List<Movie> get newMovies => List<Movie>.unmodifiable(_newMovies);

  bool _isNewLoaded = false;
  bool get isNewLoaded => _isNewLoaded;

  final LocalStorage _localeStorage = LocalStorage();
  late DateFormat _dateFormat;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<DataStructure> makeDataStructure() =>
      _movieService.makeDataStructure(_newMovies, _dateFormat);

  Future<PopularMovieResponse?> _loadNewMovies(
    String regionValue,
    String locale,
  ) async {
    try {
      final PopularMovieResponse result =
          await _apiClient.getNewMovies(regionValue, locale);
      return result;
    } on ApiClientException catch (error) {
      _errorMessage = handleErrors(error);
      return null;
    } catch (_) {
      _errorMessage = 'Unexpected error, try again later';
      return null;
    }
  }

  Future<PopularMovieResponse?> _loadNewShows(
    String regionValue,
    String locale,
  ) async {
    try {
      final PopularMovieResponse result =
          await _apiClient.getNewShows(regionValue, locale);
      return result;
    } on ApiClientException catch (error) {
      _errorMessage = handleErrors(error);
      return null;
    } catch (_) {
      _errorMessage = 'Unexpected error, try again later';
      return null;
    }
  }

  Future<void> _resetNew() async {
    _newMovies.clear();

    final PopularMovieResponse? newMoviesResponse =
        await _loadNewMovies(regionValue, _localeStorage.localeTag);
    final PopularMovieResponse? newShowsResponse =
        await _loadNewShows(regionValue, _localeStorage.localeTag);

    if (newMoviesResponse == null || newShowsResponse == null) {
      return;
    }

    for (final Movie movie in newMoviesResponse.movies) {
      movie.mediaType = 'movie';
    }
    for (final Movie movie in newShowsResponse.movies) {
      movie.mediaType = 'tv';
    }
    _newMovies.addAll(newMoviesResponse.movies as Iterable<Movie>);
    _newMovies.addAll(newShowsResponse.movies as Iterable<Movie>);

    _isNewLoaded = true;
    notifyListeners();
  }

  Future<void> setupLocale(Locale locale) async {
    final bool updateLocale = _localeStorage.updateLocale(locale);
    if (!updateLocale) {
      return;
    }
    _dateFormat = DateFormat.yMMMMd(_localeStorage.localeTag);
    await _resetNew();
    notifyListeners();
  }

  Future<void> toggleSelectedRegion(int index) async {
    isSelectedRegion = _movieService.changeSelector(isSelectedRegion, index);
    regionValue = regionsValues[index];

    await _resetNew();
    notifyListeners();
  }
}
