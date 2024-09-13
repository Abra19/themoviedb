import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/constants/media_type_enum.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/data_providers/session_data_provider.dart';
import 'package:the_movie_db/domain/entities/movie_details/movie_details.dart';
import 'package:the_movie_db/domain/entities/movie_details/movie_details_video.dart';
import 'package:the_movie_db/domain/exceptions/api_client_exceptions.dart';
import 'package:the_movie_db/domain/exceptions/handle_errors.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class MovieDetailsViewModel extends ChangeNotifier {
  MovieDetailsViewModel(this.movieId);

  final SessionDataProvider sessionProvider = SessionDataProvider();
  final ApiClient _apiClient = ApiClient();
  final int movieId;

  String _locale = '';
  late DateFormat _dateFormat;

  MovieDetails? _movieDetails;
  MovieDetails? get movieDetails => _movieDetails;

  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  String? _trailerKey;
  String? get trailerKey => _trailerKey;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void>? Function()? onSessionExpired;

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
    final String? token = await sessionProvider.getSessionId();
    if (token != null) {
      final String result = await _apiClient.isMovieInFavorites(movieId, token);
      _isFavorite = result == 'true';
    }

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

  Future<void> showTrailer(BuildContext context) async {
    await Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetailsTrailer,
      arguments: _trailerKey,
    );
  }

  Future<void> onFavoriteClick(BuildContext context) async {
    final String? token = await sessionProvider.getSessionId();
    if (token == null) {
      return;
    }
    try {
      await _apiClient.postInFavorites(
        mediaType: MediaType.movie,
        mediaId: movieId,
        isFavorite: !_isFavorite,
        token: token,
      );
      _isFavorite = !_isFavorite;
    } on ApiClientException catch (error) {
      _errorMessage = handleErrors(error);
    } catch (_) {
      _errorMessage = 'Unexpected error, try again later';
    } finally {
      notifyListeners();
    }
  }
}
