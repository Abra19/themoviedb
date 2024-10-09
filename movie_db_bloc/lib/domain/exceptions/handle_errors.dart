import 'package:the_movie_db/constants/errors_text.dart';
import 'package:the_movie_db/domain/exceptions/api_client_exceptions.dart';

String handleErrors(ApiClientException error) {
  switch (error.type) {
    case ApiClientExceptionType.network:
      return networkErrorText;
    case ApiClientExceptionType.auth:
      return authErrorText;
    case ApiClientExceptionType.api:
      return apiErrorText;
    case ApiClientExceptionType.sessionExpired:
      return sessionExpiredText;
    default:
      return unknownErrorText;
  }
}
