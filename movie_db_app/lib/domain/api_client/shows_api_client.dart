import 'package:the_movie_db/config/config.dart';
import 'package:the_movie_db/domain/api_client/endpoints.dart';
import 'package:the_movie_db/domain/api_client/network_client.dart';
import 'package:the_movie_db/domain/server_entities/movies/popular_movie_response.dart';
import 'package:the_movie_db/domain/server_entities/show_details/show_details.dart';

class ShowsApiClient {
  final NetworkClient _networkClient = NetworkClient();

  Future<PopularMovieResponse> popularShows(int page, String locale) async {
    PopularMovieResponse parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return PopularMovieResponse.fromJson(mapJson);
    }

    return _networkClient.getRequest<PopularMovieResponse>(
      Config.host,
      Endpoints.getPopularTVShows,
      parser,
      <String, dynamic>{
        'api_key': Config.apiKey,
        'language': locale,
        'page': page.toString(),
      },
    );
  }

  Future<PopularMovieResponse> searchTV(
    int page,
    String locale,
    String query,
  ) async {
    PopularMovieResponse parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return PopularMovieResponse.fromJson(mapJson);
    }

    return _networkClient.getRequest<PopularMovieResponse>(
      Config.host,
      Endpoints.searchTVShows,
      parser,
      <String, dynamic>{
        'api_key': Config.apiKey,
        'language': locale,
        'page': page.toString(),
        'include_adult': 'true',
        'query': query,
      },
    );
  }

  Future<ShowDetails> getShowDetails(
    int showId,
    String locale,
  ) async {
    ShowDetails parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return ShowDetails.fromJson(mapJson);
    }

    return _networkClient.getRequest<ShowDetails>(
      Config.host,
      Endpoints.getTVShowDetails(showId),
      parser,
      <String, dynamic>{
        'api_key': Config.apiKey,
        'language': locale,
        'append_to_response': 'credits,videos',
      },
    );
  }

  Future<PopularMovieResponse> getNewShows(
    String regionValue,
    String locale,
  ) async {
    PopularMovieResponse parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return PopularMovieResponse.fromJson(mapJson);
    }

    return _networkClient.getRequest<PopularMovieResponse>(
      Config.host,
      Endpoints.getShowsUpcoming,
      parser,
      <String, dynamic>{
        'api_key': Config.apiKey,
        'language': locale,
        'timezone': regionValue,
      },
    );
  }

  Future<PopularMovieResponse> getPlayingShows(
    String regionValue,
    String locale,
  ) async {
    PopularMovieResponse parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return PopularMovieResponse.fromJson(mapJson);
    }

    return _networkClient.getRequest<PopularMovieResponse>(
      Config.host,
      Endpoints.getPlayingTVShows,
      parser,
      <String, dynamic>{
        'api_key': Config.apiKey,
        'language': locale,
        'timezone': regionValue,
      },
    );
  }
}
