import 'package:flutter/material.dart';
import 'package:the_movie_db/config/config.dart';
import 'package:the_movie_db/constants/score_widget.dart';
import 'package:the_movie_db/types/types.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/widgets/elements/errors_widget.dart';
import 'package:the_movie_db/ui/widgets/elements/radial_percent_widget.dart';
import 'package:the_movie_db/ui/widgets/news_screen/click_news_movie.dart';

class HorizontalMoviesList extends StatelessWidget {
  const HorizontalMoviesList({
    super.key,
    required this.datas,
    required this.message,
  });

  final List<DataStructure>? datas;
  final String message;

  @override
  Widget build(BuildContext context) {
    if (datas == null || datas!.isEmpty) {
      return const SizedBox(height: 220);
    }

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
              children: datas!.map((DataStructure data) {
                return Stack(
                  children: <Widget>[
                    Container(
                      width: 95,
                      height: 220,
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          if (data.posterPath != null)
                            Image.network(
                              Config.imageUrl(data.posterPath!),
                              width: 105,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                          const SizedBox(height: 30),
                          if (data.title != null)
                            Text(
                              data.title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.newsMoviesTitleStyle,
                            ),
                          const SizedBox(height: 5),
                          Text(
                            data.date,
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
                          percent: data.percent,
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
                      child: data.type != null
                          ? ClickNewsMovieWidget(
                              index: data.id,
                              type: data.type!,
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
