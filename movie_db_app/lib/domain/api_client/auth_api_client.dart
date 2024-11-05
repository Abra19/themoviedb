import 'package:the_movie_db/config/config.dart';
import 'package:the_movie_db/domain/api_client/endpoints.dart';
import 'package:the_movie_db/domain/api_client/network_client.dart';
import 'package:the_movie_db/domain/api_client/parser.dart';

abstract class AuthApiClient {
  Future<String> auth({
    required String username,
    required String password,
  });
}

class AuthApiClientBasic implements AuthApiClient {
  AuthApiClientBasic({required this.networkClient});

  final NetworkClient networkClient;
  final String Function(dynamic json, [String? key]) _parser = Parser.parse;
  Future<String> _getToken() async {
    return networkClient.getRequest<String>(
      Config.host,
      Endpoints.getNewToken,
      _parser,
      <String, dynamic>{'api_key': Config.apiKey},
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
    return networkClient.postRequest<String>(
      Config.host,
      Endpoints.validateToken,
      'request_token',
      params,
      _parser,
      <String, dynamic>{'api_key': Config.apiKey},
    );
  }

  Future<String> _makeSession({required String token}) async {
    final Map<String, String> params = <String, String>{
      'request_token': token,
    };
    return networkClient.postRequest<String>(
      Config.host,
      Endpoints.getSession,
      'session_id',
      params,
      _parser,
      <String, dynamic>{'api_key': Config.apiKey},
    );
  }

  @override
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
}
