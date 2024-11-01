import 'package:intl/intl.dart';
import 'package:the_movie_db/types/types.dart';

class MakeDataStructure {
  static List<DataStructure> makeDataStructure(
    List<MovieListRowData> movies,
    DateFormat dateFormat,
  ) =>
      movies
          .map(
            (MovieListRowData movie) => DataStructure(
              id: movie.id,
              posterPath: movie.posterPath,
              title: movie.title ?? movie.name,
              percent: movie.voteAverage * 10,
              date: movie.releaseDate ?? movie.firstAirDate ?? '',
              type: movie.mediaType,
            ),
          )
          .toList();
}
