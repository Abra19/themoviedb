import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/entities/movie_details/movie_details.dart';
import 'package:the_movie_db/domain/entities/movie_details/movie_details_video.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class MovieDetailsModel extends ChangeNotifier {
  MovieDetailsModel(this.movieId);

  final ApiClient _apiClient = ApiClient();
  final int movieId;

  String _locale = '';
  late DateFormat _dateFormat;

  MovieDetails? _movieDetails;
  MovieDetails? get movieDetails => _movieDetails;

  String? _trailerKey;
  String? get trailerKey => _trailerKey;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

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
    _trailerKey = getTrailerKey(_movieDetails);

    notifyListeners();
  }

  void onActorClick(BuildContext context, int id) {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetailsActor,
      arguments: id,
    );
  }

  String? getTrailerKey(MovieDetails? movieDetails) {
    final List<MovieDetailVideoResult>? results = movieDetails?.videos.results;

    if (results == null) {
      return null;
    }

    final List<MovieDetailVideoResult> videos = results
        .where(
          (MovieDetailVideoResult video) =>
              video.type == 'Trailer' && video.site == 'YouTube',
        )
        .toList();
    return videos.isNotEmpty ? videos.first.key : null;
  }

  void showTrailer(BuildContext context) {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetailsTrailer,
      arguments: _trailerKey,
    );
  }
}
