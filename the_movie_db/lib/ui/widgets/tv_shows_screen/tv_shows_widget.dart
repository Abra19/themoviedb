import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/config/config.dart';
import 'package:the_movie_db/domain/entities/shows/shows.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/theme/card_movie_style.dart';
import 'package:the_movie_db/ui/widgets/elements/errors_widget.dart';
import 'package:the_movie_db/ui/widgets/tv_shows_screen/click_show_widget.dart';
import 'package:the_movie_db/ui/widgets/tv_shows_screen/tv_shows_model.dart';

class TVShowsWidget extends StatefulWidget {
  const TVShowsWidget({super.key});

  @override
  State<TVShowsWidget> createState() => _TVShowsWidgetState();
}

class _TVShowsWidgetState extends State<TVShowsWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final TVShowsViewModel model = context.read<TVShowsViewModel>();
    model.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    final TVShowsViewModel model = context.watch<TVShowsViewModel>();

    final String? message = model.errorMessage;
    return Stack(
      children: <Widget>[
        ErrorsWidget(message: message),
        ListView.builder(
          padding: const EdgeInsets.only(top: 76),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: model.shows.length,
          itemExtent: 163,
          itemBuilder: (BuildContext context, int index) {
            final TVShow show = model.shows[index];
            final String? posterPath = show.posterPath;
            model.showAtIndex(index);

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
                              Text(
                                show.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.boldBasicTextStyle,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                model.stringFromDate(show.firstAirDate),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.movieDataTextStyle,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                show.overview,
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
                  ClickShowWidget(index: index),
                ],
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: AppMovieCardStyle.findFieldDecoration,
            onChanged: model.searchShows,
          ),
        ),
      ],
    );
  }
}
