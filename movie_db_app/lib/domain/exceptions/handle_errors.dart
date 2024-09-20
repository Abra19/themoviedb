import 'package:the_movie_db/domain/exceptions/api_client_exceptions.dart';

String handleErrors(ApiClientException error) {
  switch (error.type) {
    case ApiClientExceptionType.network:
      return 'No internet connection';
    case ApiClientExceptionType.auth:
      return 'Invalid login or password';
    case ApiClientExceptionType.api:
      return 'Incorrect API key';
    case ApiClientExceptionType.sessionExpired:
      return 'Session expired';
    default:
      return 'Something went wrong, try again later';
  }
}
