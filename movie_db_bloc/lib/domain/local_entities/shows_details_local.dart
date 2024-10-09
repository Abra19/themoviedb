import 'package:the_movie_db/domain/server_entities/show_details/show_details.dart';

class ShowsDetailsLocal {
  ShowsDetailsLocal({
    required this.details,
    required this.isFavorite,
  });
  final ShowDetails details;
  final bool isFavorite;
}
