enum ApiClientExceptionType {
  network,
  auth,
  api,
  sessionExpired,
  other,
}

class ApiClientException implements Exception {
  ApiClientException(this.type);
  final ApiClientExceptionType type;
}
