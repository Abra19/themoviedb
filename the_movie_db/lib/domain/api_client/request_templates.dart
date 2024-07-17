import 'dart:convert';
import 'dart:io';

import 'package:the_movie_db/constants/errors_code.dart';
import 'package:the_movie_db/domain/exceptions/api_client_exceptions.dart';

final HttpClient _client = HttpClient();

extension HTTPClientResponseDecodeJson on HttpClientResponse {
  Future<dynamic>? decodeJson() async => transform(utf8.decoder)
      .toList()
      .then((List<String> value) => value.join())
      .then<dynamic>(
        (String value) => jsonDecode(value),
      );
}

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
    }
  }
}

Future<T> getRequest<T>(
  String host,
  String path,
  T Function(dynamic json, [String? key]) parser, [
  Map<String, dynamic>? params,
  String? key,
]) async {
  final Uri url = _makeUri(host, path, params);
  try {
    final HttpClientRequest request = await _client.getUrl(url);

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
    final HttpClientRequest request = await _client.postUrl(url);
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
  } catch (_) {
    throw ApiClientException(ApiClientExceptionType.other);
  }
}
