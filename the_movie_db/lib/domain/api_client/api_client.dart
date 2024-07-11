import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:the_movie_db/domain/api_client/request_templates.dart';
import 'package:the_movie_db/domain/entities/movie_details.dart';
import 'package:the_movie_db/domain/entities/popular_movie_response.dart';

class ApiClient {
  static const String _host = 'https://api.themoviedb.org/3';
  static const String _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static final String? _apiKey = dotenv.env['API_KEY'];

  static String imageUrl(String path) => '$_imageUrl$path';

  String _parser(dynamic json, [String? key]) {
    final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
    return mapJson[key] as String;
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
      },
    );
  }
}
