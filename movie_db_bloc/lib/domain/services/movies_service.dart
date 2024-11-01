import 'package:the_movie_db/constants/media_type_enum.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/data_providers/session_data_provider.dart';
import 'package:the_movie_db/domain/exceptions/api_client_exceptions.dart';
import 'package:the_movie_db/domain/local_entities/movies_details_local.dart';
import 'package:the_movie_db/domain/local_entities/shows_details_local.dart';
import 'package:the_movie_db/domain/server_entities/movie_details/movie_details.dart';
import 'package:the_movie_db/domain/server_entities/show_details/show_details.dart';

class MoviesService {
  final ApiClient _apiClient = ApiClient();
  final SessionDataProvider sessionProvider = SessionDataProvider();

  void handleAPIClientException(
    ApiClientException error,
    Function()? onSessionExpired,
  ) {
    switch (error.type) {
      case ApiClientExceptionType.sessionExpired:
        onSessionExpired?.call();
      default:
        break;
    }
  }

  Future<MoviesDetailsLocal> loadMovieDetails({
    required int movieId,
    required String locale,
  }) async {
    final MovieDetails movieDetails =
        await _apiClient.getMovieDetails(movieId, locale);
    final String? token = await sessionProvider.getSessionId();
    bool isFavorite = false;
    if (token != null) {
      final String result = await _apiClient.isMovieInFavorites(movieId, token);
      isFavorite = result == 'true';
    }
    return MoviesDetailsLocal(
      details: movieDetails,
      isFavorite: isFavorite,
    );
  }

  Future<ShowsDetailsLocal> loadShowDetails({
    required int showId,
    required String locale,
  }) async {
    final ShowDetails showDetails =
        await _apiClient.getShowDetails(showId, locale);
    final String? token = await sessionProvider.getSessionId();
    bool isFavorite = false;
    if (token != null) {
      final String result = await _apiClient.isShowInFavorites(showId, token);
      isFavorite = result == 'true';
    }
    return ShowsDetailsLocal(
      details: showDetails,
      isFavorite: isFavorite,
    );
  }

  Future<void> postInFavoriteOnClick({
    required int movieId,
    required bool isFavorite,
    required MediaType mediaType,
  }) async {
    final String? token = await sessionProvider.getSessionId();
    if (token == null) {
      return;
    }
    await _apiClient.postInFavorites(
      mediaType: mediaType,
      mediaId: movieId,
      isFavorite: !isFavorite,
      token: token,
    );
  }
}
