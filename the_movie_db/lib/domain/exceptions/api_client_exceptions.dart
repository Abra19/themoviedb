enum ApiClientExceptionType {
  network,
  auth,
  api,
  other,
}

class ApiClientException implements Exception {
  ApiClientException(this.type);
  final ApiClientExceptionType type;
}
