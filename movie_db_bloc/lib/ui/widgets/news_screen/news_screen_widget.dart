import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/factories/screen_factories.dart';

class NewsScreenWidget extends StatelessWidget {
  const NewsScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ScreenFactories screenFactory = ScreenFactories();
    return ListView(
      children: <Widget>[
        screenFactory.makeTrendingMovies(),
        const SizedBox(height: 20),
        screenFactory.makeNewMovies(),
        const SizedBox(height: 20),
        screenFactory.makePlayingMovies(),
      ],
    );
  }
}
