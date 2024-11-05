import 'package:the_movie_db/config/config.dart';
import 'package:the_movie_db/constants/media_type_enum.dart';
import 'package:the_movie_db/domain/api_client/endpoints.dart';
import 'package:the_movie_db/domain/api_client/network_client.dart';
import 'package:the_movie_db/domain/api_client/parser.dart';
import 'package:the_movie_db/domain/server_entities/movies/popular_movie_response.dart';

abstract class FavoritesApiClient {
  Future<String> isMovieInFavorites(
    int movieId,
    String token,
  );

  Future<String> isShowInFavorites(
    int showId,
    String token,
  );

  Future<String> postInFavorites({
    required MediaType mediaType,
    required int mediaId,
    required bool isFavorite,
    required String token,
  });

  Future<PopularMovieResponse> getFavoriteMovies(
    String locale,
    int page,
    String token,
  );

  Future<PopularMovieResponse> getFavoriteShows(
    String locale,
    int page,
    String token,
  );
}

class FavoritesApiClientBasic implements FavoritesApiClient {
  FavoritesApiClientBasic({required this.networkClient});

  final NetworkClient networkClient;
  final String Function(dynamic json, [String? key]) _parser = Parser.parse;

  @override
  Future<String> isMovieInFavorites(
    int movieId,
    String token,
  ) async {
    return networkClient.getRequest(
      Config.host,
      Endpoints.isMovieInFavorite(movieId),
      _parser,
      <String, dynamic>{
        'api_key': Config.apiKey,
        'session_id': token,
      },
      'favorite',
    );
  }

  @override
  Future<String> isShowInFavorites(
    int showId,
    String token,
  ) async {
    return networkClient.getRequest(
      Config.host,
      Endpoints.isTVShowInFavorite(showId),
      _parser,
      <String, dynamic>{
        'api_key': Config.apiKey,
        'session_id': token,
      },
      'favorite',
    );
  }

  @override
  Future<String> postInFavorites({
    required MediaType mediaType,
    required int mediaId,
    required bool isFavorite,
    required String token,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'media_type': mediaType.asString(),
      'media_id': mediaId,
      'favorite': isFavorite,
    };
    return networkClient.postRequest<String>(
      Config.host,
      Endpoints.postInFavorite(Config.accountId),
      'status_message',
      params,
      _parser,
      <String, dynamic>{
        'api_key': Config.apiKey,
        'session_id': token,
      },
    );
  }

  @override
  Future<PopularMovieResponse> getFavoriteMovies(
    String locale,
    int page,
    String token,
  ) async {
    PopularMovieResponse parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return PopularMovieResponse.fromJson(mapJson);
    }

    return networkClient.getRequest<PopularMovieResponse>(
      Config.host,
      Endpoints.getFavoriteMovies(Config.accountId),
      parser,
      <String, dynamic>{
        'api_key': Config.apiKey,
        'language': locale,
        'session_id': token,
        'page': page.toString(),
      },
    );
  }

  @override
  Future<PopularMovieResponse> getFavoriteShows(
    String locale,
    int page,
    String token,
  ) async {
    PopularMovieResponse parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return PopularMovieResponse.fromJson(mapJson);
    }

    return networkClient.getRequest<PopularMovieResponse>(
      Config.host,
      Endpoints.getFavoriteTVShows(Config.accountId),
      parser,
      <String, dynamic>{
        'api_key': Config.apiKey,
        'language': locale,
        'session_id': token,
        'page': page.toString(),
      },
    );
  }
}
