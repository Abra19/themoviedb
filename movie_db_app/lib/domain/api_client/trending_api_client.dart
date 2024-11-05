import 'package:the_movie_db/config/config.dart';
import 'package:the_movie_db/domain/api_client/endpoints.dart';
import 'package:the_movie_db/domain/api_client/network_client.dart';
import 'package:the_movie_db/domain/server_entities/movies/popular_movie_response.dart';

abstract class TrendingApiClient {
  Future<PopularMovieResponse> getAllInTrend(
    String trendPeriod,
    String locale,
  );
}

class TrendingApiClientBasic implements TrendingApiClient {
  const TrendingApiClientBasic({required this.networkClient});

  final NetworkClient networkClient;

  @override
  Future<PopularMovieResponse> getAllInTrend(
    String trendPeriod,
    String locale,
  ) async {
    PopularMovieResponse parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return PopularMovieResponse.fromJson(mapJson);
    }

    return networkClient.getRequest<PopularMovieResponse>(
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
