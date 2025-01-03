import 'dart:convert';
import 'dart:io';

import 'package:the_movie_db/constants/errors_code.dart';
import 'package:the_movie_db/domain/exceptions/api_client_exceptions.dart';
import 'package:the_movie_db/library/http_client/app_http_client.dart';

abstract class NetworkClient {
  Future<T> getRequest<T>(
    String host,
    String path,
    T Function(dynamic json, [String? key]) parser, [
    Map<String, dynamic>? params,
    String? key,
  ]);
  Future<T> postRequest<T>(
    String host,
    String path,
    String key,
    Map<String, dynamic> bodyParams,
    T Function(dynamic json, String key) parser, [
    Map<String, dynamic>? urlParams,
  ]);
}

class NetworkClientBasic implements NetworkClient {
  const NetworkClientBasic({required this.client});

  final AppHttpClient client;

  Uri _makeUri(String host, String path, [Map<String, dynamic>? params]) {
    final Uri uri = Uri.parse('$host$path');
    if (params != null) {
      return uri.replace(queryParameters: params);
    }
    return uri;
  }

  void _validateResponse(HttpClientResponse response, dynamic json) {
    final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
    final int code = mapJson['status_code'] as int? ?? 0;
    if (response.statusCode == 401) {
      switch (code) {
        case loginError:
          throw ApiClientException(ApiClientExceptionType.auth);
        case apiError:
          throw ApiClientException(ApiClientExceptionType.api);
        case sessionExpired:
          throw ApiClientException(ApiClientExceptionType.sessionExpired);
        default:
          throw ApiClientException(ApiClientExceptionType.other);
      }
    }
  }

  @override
  Future<T> getRequest<T>(
    String host,
    String path,
    T Function(dynamic json, [String? key]) parser, [
    Map<String, dynamic>? params,
    String? key,
  ]) async {
    final Uri url = _makeUri(host, path, params);

    try {
      final HttpClientRequest request = await client.getUrl(url);

      final HttpClientResponse response = await request.close();
      final dynamic json = await response.decodeJson();
      _validateResponse(response, json);
      return parser(json, key);
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  @override
  Future<T> postRequest<T>(
    String host,
    String path,
    String key,
    Map<String, dynamic> bodyParams,
    T Function(dynamic json, String key) parser, [
    Map<String, dynamic>? urlParams,
  ]) async {
    final Uri url = _makeUri(host, path, urlParams);
    try {
      final HttpClientRequest request = await client.postUrl(url);
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(bodyParams));

      final HttpClientResponse response = await request.close();
      final dynamic json = await response.decodeJson();

      _validateResponse(response, json);
      return parser(json, key);
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (e) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }
}

extension HTTPClientResponseDecodeJson on HttpClientResponse {
  Future<dynamic>? decodeJson() async => transform(utf8.decoder)
      .toList()
      .then((List<String> value) => value.join())
      .then<dynamic>(
        (String value) => jsonDecode(value),
      );
}
