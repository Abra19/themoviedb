import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/entities/movies.dart';
import 'package:the_movie_db/library/providers/notify_provider.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/theme/card_movie_style.dart';
import 'package:the_movie_db/ui/widgets/movie_screen/click_movie_widget.dart';
import 'package:the_movie_db/ui/widgets/movie_screen/movies_widget_model.dart';

class MoviesWidget extends StatelessWidget {
  const MoviesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final MoviesWidgetModel? model =
        NotifyProvider.watch<MoviesWidgetModel>(context);
    if (model == null) {
      return const SizedBox.shrink();
    }
    final String? message = model.errorMessage;
    return Stack(
      children: <Widget>[
        if (message != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 16),
            child: Column(
              children: <Widget>[
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          )
        else
          const SizedBox.shrink(),
        ListView.builder(
          padding: const EdgeInsets.only(top: 76),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: model.movies.length,
          itemExtent: 163,
          itemBuilder: (BuildContext context, int index) {
            final Movie movie = model.movies[index];
            final String? posterPath = movie.posterPath;
            model.showMovieAtIndex(index);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: AppMovieCardStyle.cardDecoration,
                    clipBehavior: Clip.hardEdge,
                    child: Row(
                      children: <Widget>[
                        if (posterPath != null)
                          Image.network(
                            ApiClient.imageUrl(posterPath),
                            width: 95,
                          )
                        else
                          const SizedBox.shrink(),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(height: 10),
                              Text(
                                movie.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.boldBasicTextStyle,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                model.stringFromDate(movie.releaseDate),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.movieDataTextStyle,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                movie.overview,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                  ClickMovieWidget(index: index),
                ],
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: AppMovieCardStyle.findFieldDecoration,
            onChanged: model.searchMovies,
          ),
        ),
      ],
    );
  }
}
