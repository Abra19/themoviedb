import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/entities/movie_details.dart';

class MovieDetailsModel extends ChangeNotifier {
  MovieDetailsModel(this.movieId);

  final ApiClient _apiClient = ApiClient();
  final int movieId;

  String _locale = '';
  late DateFormat _dateFormat;

  MovieDetails? _movieDetails;
  MovieDetails? get movieDetails => _movieDetails;

  Future<void> setupLocale(BuildContext context) async {
    final String locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) {
      return;
    }
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(_locale);
    await loadMovieDetails(movieId);
  }

  Future<void> loadMovieDetails(int movieId) async {
    _movieDetails = await _apiClient.getMovieDetails(movieId, _locale);
    notifyListeners();
  }
}
