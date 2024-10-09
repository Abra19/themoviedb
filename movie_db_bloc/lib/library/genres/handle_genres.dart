import 'package:the_movie_db/domain/server_entities/general/genre.dart';

String handleGenres(List<Genre> listGenres) => listGenres.isEmpty
    ? ''
    : listGenres
        .map(
          (Genre el) => el.name[0].toUpperCase() + el.name.substring(1),
        )
        .join(', ');
