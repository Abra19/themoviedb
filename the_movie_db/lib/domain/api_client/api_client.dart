import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:the_movie_db/constants/media_type_enum.dart';
import 'package:the_movie_db/domain/api_client/request_templates.dart';
import 'package:the_movie_db/domain/entities/actors/actor_details.dart';
import 'package:the_movie_db/domain/entities/movie_details/movie_details.dart';
import 'package:the_movie_db/domain/entities/movies/popular_movie_response.dart';
import 'package:the_movie_db/domain/entities/show_details/show_details.dart';
import 'package:the_movie_db/domain/entities/shows/popular_shows_response.dart';

class ApiClient {
  static const String _host = 'https://api.themoviedb.org/3';
  static const String _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static final String? _apiKey = dotenv.env['API_KEY'];
  static final String? _accountId = dotenv.env['ACCOUNT_ID'];

  static String imageUrl(String path) => '$_imageUrl$path';

  String _parser(dynamic json, [String? key]) {
    final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
    final dynamic value = mapJson[key] ?? '';
    if (value is String) {
      return value;
    } else if (value is bool) {
      return value.toString();
    } else {
      throw Exception('Unsupported type for key $key');
    }
  }

  Future<String> _getToken() async {
    return getRequest<String>(
      _host,
      '/authentication/token/new',
      _parser,
      <String, dynamic>{'api_key': _apiKey},
      'request_token',
    );
  }

  Future<String> _validateUser({
    required String username,
    required String password,
    required String token,
  }) async {
    final Map<String, String> params = <String, String>{
      'username': username,
      'password': password,
      'request_token': token,
    };
    return postRequest<String>(
      _host,
      '/authentication/token/validate_with_login',
      'request_token',
      params,
      _parser,
      <String, dynamic>{'api_key': _apiKey},
    );
  }

  Future<String> _makeSession({required String token}) async {
    final Map<String, String> params = <String, String>{
      'request_token': token,
    };
    return postRequest<String>(
      _host,
      '/authentication/session/new',
      'session_id',
      params,
      _parser,
      <String, dynamic>{'api_key': _apiKey},
    );
  }

  Future<String> auth({
    required String username,
    required String password,
  }) async {
    final String token = await _getToken();
    final String validToken = await _validateUser(
      username: username,
      password: password,
      token: token,
    );
    return _makeSession(token: validToken);
  }

  Future<PopularMovieResponse> popularMovie(int page, String locale) async {
    PopularMovieResponse parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return PopularMovieResponse.fromJson(mapJson);
    }

    return getRequest<PopularMovieResponse>(
      _host,
      '/movie/popular',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'language': locale,
        'page': page.toString(),
      },
    );
  }

  Future<PopularMovieResponse> searchMovie(
    int page,
    String locale,
    String query,
  ) async {
    PopularMovieResponse parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return PopularMovieResponse.fromJson(mapJson);
    }

    return getRequest<PopularMovieResponse>(
      _host,
      '/search/movie',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'language': locale,
        'page': page.toString(),
        'include_adult': 'true',
        'query': query,
      },
    );
  }

  Future<ActorDetails> showActor(
    int actorId,
    String locale,
  ) async {
    ActorDetails parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return ActorDetails.fromJson(mapJson);
    }

    return getRequest<ActorDetails>(
      _host,
      '/person/$actorId',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'language': locale,
      },
    );
  }

  Future<MovieDetails> getMovieDetails(
    int movieId,
    String locale,
  ) async {
    MovieDetails parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return MovieDetails.fromJson(mapJson);
    }

    return getRequest<MovieDetails>(
      _host,
      '/movie/$movieId',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'language': locale,
        'append_to_response': 'credits,videos',
      },
    );
  }

  Future<PopularTVShowsResponse> popularShows(int page, String locale) async {
    PopularTVShowsResponse parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return PopularTVShowsResponse.fromJson(mapJson);
    }

    return getRequest<PopularTVShowsResponse>(
      _host,
      '/tv/popular',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'language': locale,
        'page': page.toString(),
      },
    );
  }

  Future<PopularTVShowsResponse> searchTV(
    int page,
    String locale,
    String query,
  ) async {
    PopularTVShowsResponse parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return PopularTVShowsResponse.fromJson(mapJson);
    }

    return getRequest<PopularTVShowsResponse>(
      _host,
      '/search/tv',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'language': locale,
        'page': page.toString(),
        'include_adult': 'true',
        'query': query,
      },
    );
  }

  Future<ShowDetails> getShowDetails(
    int showId,
    String locale,
  ) async {
    ShowDetails parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return ShowDetails.fromJson(mapJson);
    }

    return getRequest<ShowDetails>(
      _host,
      '/tv/$showId',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'language': locale,
        'append_to_response': 'credits,videos',
      },
    );
  }

  Future<PopularMovieResponse> getAllInTrend(
    String trendPeriod,
    String locale,
  ) async {
    PopularMovieResponse parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return PopularMovieResponse.fromJson(mapJson);
    }

    return getRequest<PopularMovieResponse>(
      _host,
      '/trending/all/$trendPeriod',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'language': locale,
      },
    );
  }

  Future<PopularMovieResponse> getNewMovies(
    String regionValue,
    String locale,
  ) async {
    PopularMovieResponse parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return PopularMovieResponse.fromJson(mapJson);
    }

    return getRequest<PopularMovieResponse>(
      _host,
      '/movie/upcoming',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'language': locale,
        'region': regionValue,
      },
    );
  }

  Future<PopularMovieResponse> getNewShows(
    String regionValue,
    String locale,
  ) async {
    PopularMovieResponse parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return PopularMovieResponse.fromJson(mapJson);
    }

    return getRequest<PopularMovieResponse>(
      _host,
      '/tv/on_the_air',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'language': locale,
        'timezone': regionValue,
      },
    );
  }

  Future<PopularMovieResponse> getPlayingMovies(
    String regionValue,
    String locale,
  ) async {
    PopularMovieResponse parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return PopularMovieResponse.fromJson(mapJson);
    }

    return getRequest<PopularMovieResponse>(
      _host,
      '/movie/now_playing',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'language': locale,
        'region': regionValue,
      },
    );
  }

  Future<PopularMovieResponse> getPlayingShows(
    String regionValue,
    String locale,
  ) async {
    PopularMovieResponse parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return PopularMovieResponse.fromJson(mapJson);
    }

    return getRequest<PopularMovieResponse>(
      _host,
      '/tv/airing_today',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'language': locale,
        'timezone': regionValue,
      },
    );
  }

  Future<String> isMovieInFavorites(
    int movieId,
    String token,
  ) async {
    return getRequest(
      _host,
      '/movie/$movieId/account_states',
      _parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'session_id': token,
      },
      'favorite',
    );
  }

  Future<String> isShowInFavorites(
    int showId,
    String token,
  ) async {
    return getRequest(
      _host,
      '/tv/$showId/account_states',
      _parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'session_id': token,
      },
      'favorite',
    );
  }

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
    return postRequest<String>(
      _host,
      '/account/$_accountId/favorite',
      'status_message',
      params,
      _parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'session_id': token,
      },
    );
  }

  Future<PopularMovieResponse> getFavoriteMovies(
    String locale,
    int page,
    String token,
  ) async {
    PopularMovieResponse parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return PopularMovieResponse.fromJson(mapJson);
    }

    return getRequest<PopularMovieResponse>(
      _host,
      '/account/$_accountId/favorite/movies',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'language': locale,
        'session_id': token,
        'page': page.toString(),
      },
    );
  }

  Future<PopularMovieResponse> getFavoriteShows(
    String locale,
    int page,
    String token,
  ) async {
    PopularMovieResponse parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return PopularMovieResponse.fromJson(mapJson);
    }

    return getRequest<PopularMovieResponse>(
      _host,
      '/account/$_accountId/favorite/tv',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'language': locale,
        'session_id': token,
        'page': page.toString(),
      },
    );
  }
}
