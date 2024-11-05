import 'package:flutter/material.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class NewsScreenWidget extends StatelessWidget {
  const NewsScreenWidget({super.key, required this.screensFactory});

  final ScreensFactory screensFactory;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        screensFactory.makeTrendingMovies(),
        const SizedBox(height: 20),
        screensFactory.makeNewMovies(),
        const SizedBox(height: 20),
        screensFactory.makePlayingMovies(),
      ],
    );
  }
}
