import 'package:the_movie_db/domain/server_entities/movie_details/movie_details.dart';

class MoviesDetailsLocal {
  MoviesDetailsLocal({
    required this.details,
    required this.isFavorite,
  });
  final MovieDetails details;
  final bool isFavorite;
}
