import 'package:flutter/material.dart';
import 'package:the_movie_db/constants/score_widget.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/entities/movies/movies.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/widgets/elements/errors_widget.dart';
import 'package:the_movie_db/ui/widgets/elements/radial_percent_widget.dart';
import 'package:the_movie_db/ui/widgets/news_screen/click_news_movie.dart';
import 'package:the_movie_db/ui/widgets/news_screen/news_screen_model.dart';

class HorizontalMoviesList extends StatelessWidget {
  const HorizontalMoviesList({
    super.key,
    required this.model,
    required this.movies,
  });
  final NewsScreenModel? model;
  final List<Movie>? movies;

  @override
  Widget build(BuildContext context) {
    if (model == null || movies == null || movies!.isEmpty) {
      return const SizedBox.shrink();
    }
    final String? message = model!.errorMessage;

    final ScrollController scrollController = ScrollController();

    return Stack(
      children: <Widget>[
        ErrorsWidget(message: message),
        Scrollbar(
          controller: scrollController,
          thumbVisibility: true,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: scrollController,
            primary: false,
            child: Row(
              children: movies!.map((Movie movie) {
                final String? posterPath = movie.posterPath;
                final String? title = movie.title ?? movie.name;
                final double percent = movie.voteAverage * 10;
                return Stack(
                  children: <Widget>[
                    Container(
                      width: 95,
                      height: 220,
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          if (posterPath != null)
                            Image.network(
                              ApiClient.imageUrl(posterPath),
                              width: 105,
                            )
                          else
                            const SizedBox.shrink(),
                          const SizedBox(height: 30),
                          if (title != null)
                            Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.newsMoviesTitleStyle,
                            )
                          else
                            const SizedBox.shrink(),
                          const SizedBox(height: 5),
                          Text(
                            model!.stringFromDate(
                              movie.releaseDate ?? movie.firstAirDate,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.movieDataNewsTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 135,
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: RadialPercentWidget(
                          percent: percent,
                          lineWidth: lineWidth,
                          lineColor: lineColor,
                          fillColor: fillColor,
                          freeColor: freeColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 95,
                      height: 220,
                      child: movie.mediaType != null
                          ? ClickNewsMovieWidget(
                              index: movie.id,
                              type: movie.mediaType!,
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
