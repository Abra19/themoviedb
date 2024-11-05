import 'package:the_movie_db/config/config.dart';
import 'package:the_movie_db/domain/api_client/endpoints.dart';
import 'package:the_movie_db/domain/api_client/network_client.dart';
import 'package:the_movie_db/domain/server_entities/movie_details/movie_details.dart';
import 'package:the_movie_db/domain/server_entities/movies/popular_movie_response.dart';

abstract class MoviesApiClient {
  Future<PopularMovieResponse> popularMovie(int page, String locale);
  Future<PopularMovieResponse> searchMovie(
    int page,
    String locale,
    String query,
  );
  Future<MovieDetails> getMovieDetails(
    int movieId,
    String locale,
  );
  Future<PopularMovieResponse> getNewMovies(
    String regionValue,
    String locale,
  );
  Future<PopularMovieResponse> getPlayingMovies(
    String regionValue,
    String locale,
  );
}

class MoviesApiClientBasic implements MoviesApiClient {
  const MoviesApiClientBasic({required this.networkClient});

  final NetworkClient networkClient;

  @override
  Future<PopularMovieResponse> popularMovie(int page, String locale) async {
    PopularMovieResponse parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return PopularMovieResponse.fromJson(mapJson);
    }

    return networkClient.getRequest<PopularMovieResponse>(
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

  @override
  Future<PopularMovieResponse> searchMovie(
    int page,
    String locale,
    String query,
  ) async {
    PopularMovieResponse parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return PopularMovieResponse.fromJson(mapJson);
    }

    return networkClient.getRequest<PopularMovieResponse>(
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

  @override
  Future<MovieDetails> getMovieDetails(
    int movieId,
    String locale,
  ) async {
    MovieDetails parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return MovieDetails.fromJson(mapJson);
    }

    return networkClient.getRequest<MovieDetails>(
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

  @override
  Future<PopularMovieResponse> getNewMovies(
    String regionValue,
    String locale,
  ) async {
    PopularMovieResponse parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return PopularMovieResponse.fromJson(mapJson);
    }

    return networkClient.getRequest<PopularMovieResponse>(
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

  @override
  Future<PopularMovieResponse> getPlayingMovies(
    String regionValue,
    String locale,
  ) async {
    PopularMovieResponse parser(dynamic json, [String? key]) {
      final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
      return PopularMovieResponse.fromJson(mapJson);
    }

    return networkClient.getRequest<PopularMovieResponse>(
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
