import 'package:flutter/material.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class ClickNewsMovieWidget extends StatelessWidget {
  const ClickNewsMovieWidget({
    super.key,
    required this.index,
    required this.type,
  });
  final int index;
  final String type;

  @override
  Widget build(BuildContext context) {
    void onMovieClick(BuildContext context, int id, String type) {
      if (type == 'tv') {
        Navigator.of(context).pushNamed(
          MainNavigationRouteNames.tvDetails,
          arguments: id,
        );
      } else {
        Navigator.of(context).pushNamed(
          MainNavigationRouteNames.movieDetails,
          arguments: id,
        );
      }
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onMovieClick(context, index, type),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
