import 'package:flutter/material.dart';
import 'package:the_movie_db/config/config.dart';
import 'package:the_movie_db/domain/entities/movies/movies.dart';
import 'package:the_movie_db/library/providers/notify_provider.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/theme/card_movie_style.dart';
import 'package:the_movie_db/ui/widgets/elements/errors_widget.dart';
import 'package:the_movie_db/ui/widgets/favorites/click_favorite_widget.dart';
import 'package:the_movie_db/ui/widgets/favorites/favorite_model.dart';

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  @override
  Widget build(BuildContext context) {
    final FavoriteViewModel? model =
        NotifyProvider.watch<FavoriteViewModel>(context);
    if (model == null) {
      return const SizedBox.shrink();
    }
    final String? message = model.errorMessage;
    return Stack(
      children: <Widget>[
        ErrorsWidget(message: message),
        ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: model.favorites.length,
          itemExtent: 163,
          itemBuilder: (BuildContext context, int index) {
            final Movie movie = model.favorites[index];
            final String? posterPath = movie.posterPath;
            model.showFavoriteAtIndex(index);
            final String? title = movie.title ?? movie.name;

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
                            Config.imageUrl(posterPath),
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
                              if (title != null)
                                Text(
                                  title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle.boldBasicTextStyle,
                                )
                              else
                                const SizedBox.shrink(),
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
                  ClickFavoriteWidget(
                    index: movie.id,
                    type: movie.mediaType!,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
