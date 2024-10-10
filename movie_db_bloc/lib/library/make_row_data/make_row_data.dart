import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/server_entities/movies/movies.dart';
import 'package:the_movie_db/library/dates/handle_dates.dart';
import 'package:the_movie_db/types/types.dart';

class HandleRowData {
  static MovieListRowData makeRowData(Movie movie, DateFormat dateFormat) {
    final DateTime? movieDate = movie.releaseDate;
    final DateTime? showDate = movie.firstAirDate;
    final String? releaseDate =
        movieDate != null ? stringFromDate(movieDate, dateFormat) : null;
    final String? firstAirDate =
        showDate != null ? stringFromDate(showDate, dateFormat) : null;
    return MovieListRowData(
      id: movie.id,
      title: movie.title,
      name: movie.name,
      posterPath: movie.posterPath,
      releaseDate: releaseDate,
      firstAirDate: firstAirDate,
      overview: movie.overview,
      mediaType: movie.mediaType,
    );
  }
}
