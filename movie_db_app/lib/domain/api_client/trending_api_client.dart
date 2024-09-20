import 'package:the_movie_db/config/config.dart';
import 'package:the_movie_db/domain/api_client/endpoints.dart';
import 'package:the_movie_db/domain/api_client/network_client.dart';
import 'package:the_movie_db/domain/server_entities/movies/popular_movie_response.dart';

class TrendingApiClient {
  final NetworkClient _networkClient = NetworkClient();

  Future<PopularMovieResponse> getAllInTrend(
    String trendPeriod,
    String locale,
  ) async {
    PopularMovieResponse parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return PopularMovieResponse.fromJson(mapJson);
    }

    return _networkClient.getRequest<PopularMovieResponse>(
      Config.host,
      Endpoints.getTrended(trendPeriod),
      parser,
      <String, dynamic>{
        'api_key': Config.apiKey,
        'language': locale,
      },
    );
  }
}
