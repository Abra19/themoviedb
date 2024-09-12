import 'package:the_movie_db/config/config.dart';
import 'package:the_movie_db/domain/api_client/endpoints.dart';
import 'package:the_movie_db/domain/api_client/network_client.dart';
import 'package:the_movie_db/domain/entities/movie_details/movie_details.dart';
import 'package:the_movie_db/domain/entities/movies/popular_movie_response.dart';

class MoviesApiClient {
  final NetworkClient _networkClient = NetworkClient();

  Future<PopularMovieResponse> popularMovie(int page, String locale) async {
    PopularMovieResponse parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return PopularMovieResponse.fromJson(mapJson);
    }

    return _networkClient.getRequest<PopularMovieResponse>(
      Config.host,
      Endpoints.getPopularMovies,
      parser,
      <String, dynamic>{
        'api_key': Config.apiKey,
        'language': locale,
        'page': page.toString(),
      },
    );
  }

  Future<PopularMovieResponse> searchMovie(
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
      Endpoints.searchMovies,
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

  Future<MovieDetails> getMovieDetails(
    int movieId,
    String locale,
  ) async {
    MovieDetails parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return MovieDetails.fromJson(mapJson);
    }

    return _networkClient.getRequest<MovieDetails>(
      Config.host,
      Endpoints.getMovieDetails(movieId),
      parser,
      <String, dynamic>{
        'api_key': Config.apiKey,
        'language': locale,
        'append_to_response': 'credits,videos',
      },
    );
  }

  Future<PopularMovieResponse> getNewMovies(
    String regionValue,
    String locale,
  ) async {
    PopularMovieResponse parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return PopularMovieResponse.fromJson(mapJson);
    }

    return _networkClient.getRequest<PopularMovieResponse>(
      Config.host,
      Endpoints.getMoviesUpcoming,
      parser,
      <String, dynamic>{
        'api_key': Config.apiKey,
        'language': locale,
        'region': regionValue,
      },
    );
  }

  Future<PopularMovieResponse> getPlayingMovies(
    String regionValue,
    String locale,
  ) async {
    PopularMovieResponse parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return PopularMovieResponse.fromJson(mapJson);
    }

    return _networkClient.getRequest<PopularMovieResponse>(
      Config.host,
      Endpoints.getPlayingMovies,
      parser,
      <String, dynamic>{
        'api_key': Config.apiKey,
        'language': locale,
        'region': regionValue,
      },
    );
  }
}
