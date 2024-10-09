import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/constants/media_type_enum.dart';
import 'package:the_movie_db/domain/data_providers/local_storage.dart';
import 'package:the_movie_db/domain/local_entities/movies_details_local.dart';
import 'package:the_movie_db/domain/server_entities/movie_details/movie_details.dart';
import 'package:the_movie_db/domain/server_entities/movie_details/movie_details_credits.dart';
import 'package:the_movie_db/domain/server_entities/movie_details/movie_details_video.dart';
import 'package:the_movie_db/domain/exceptions/api_client_exceptions.dart';
import 'package:the_movie_db/domain/exceptions/handle_errors.dart';
import 'package:the_movie_db/domain/services/movies_service.dart';
import 'package:the_movie_db/library/crews/handle_crew.dart';
import 'package:the_movie_db/library/dates/handle_dates.dart';
import 'package:the_movie_db/library/dates/handle_time.dart';
import 'package:the_movie_db/library/genres/handle_genres.dart';
import 'package:the_movie_db/library/lists/handle_lists.dart';
import 'package:the_movie_db/types/types.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class MovieDetailsViewModel extends ChangeNotifier {
  MovieDetailsViewModel(this.movieId);

  final int movieId;

  final MoviesService _moviesService = MoviesService();

  final LocalStorage _localeStorage = LocalStorage();
  late DateFormat _dateFormat;

  MovieDetailsData data = MovieDetailsData();

  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  String? _trailerKey;
  String? get trailerKey => _trailerKey;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void>? Function()? onSessionExpired;

  Future<void> setupLocale(Locale locale) async {
    final bool updateLocale = _localeStorage.updateLocale(locale);
    if (!updateLocale) {
      return;
    }
    _dateFormat = DateFormat.yMMMMd(_localeStorage.localeTag);
    await loadMovieDetails(movieId);
    notifyListeners();
  }

  void updateDates(MovieDetails details) {
    final DateTime? releaseDate = details.releaseDate;
    data.releaseYear = makeYearFromDate(releaseDate);
    data.releaseDate = stringFromDate(releaseDate, _dateFormat);
  }

  void updateCrew(MovieDetails details) {
    final List<Crew> crew = details.credits.crew;
    if (crew.isEmpty) {
      data.crew = <CrewData>[];
      return;
    }

    data.crew = handleCrew(crew);
  }

  void updateData(MovieDetails? details) {
    data.isLoading = details == null;
    if (details != null) {
      data.title = details.title ?? '';
      data.backdropPath = details.backdropPath;
      data.posterPath = details.posterPath;
      updateDates(details);
      data.voteAverage = details.voteAverage * 10;
      data.countries = handleList(details.productionCountries);
      data.runtime = handleTime(details.runtime ?? 0);
      data.genres = handleGenres(details.genres);
      data.overview = details.overview ?? '';
      updateCrew(details);
      data.cast = details.credits.cast;
    }
    notifyListeners();
  }

  Future<void> loadMovieDetails(int movieId) async {
    try {
      final MoviesDetailsLocal data = await _moviesService.loadMovieDetails(
        movieId: movieId,
        locale: _localeStorage.localeTag,
      );
      _isFavorite = data.isFavorite;
      updateData(data.details);
      _trailerKey = getTrailerKey(data.details);
    } on ApiClientException catch (error) {
      _moviesService.handleAPIClientException(error, onSessionExpired);
    } catch (_) {
      _errorMessage = 'Unexpected error, try again later';
    } finally {
      notifyListeners();
    }
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

  Future<void> onFavoriteClick(int movieId) async {
    try {
      await _moviesService.postInFavoriteOnClick(
        movieId: movieId,
        isFavorite: _isFavorite,
        mediaType: MediaType.movie,
      );
      _isFavorite = !_isFavorite;
    } on ApiClientException catch (error) {
      _errorMessage = handleErrors(error);
      _moviesService.handleAPIClientException(error, onSessionExpired);
    } catch (_) {
      _errorMessage = 'Unexpected error, try again later';
    } finally {
      notifyListeners();
    }
  }
}
