import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/config/config.dart';
import 'package:the_movie_db/domain/server_entities/show_details/show_details.dart';
import 'package:the_movie_db/ui/theme/app_colors.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/widgets/tv_shows_details/tv_details_model.dart';

class TVProductionWidget extends StatelessWidget {
  const TVProductionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bool inProduction =
        context.select((TVDetailsViewModel model) => model.data.inProduction);

    if (!inProduction) {
      return const SizedBox.shrink();
    }

    return const ColoredBox(
      color: AppColors.appScreenCastColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Text('Current Season', style: AppTextStyle.castTitleStyle),
          ),
          SizedBox(height: 10),
          Scrollbar(
            child: _LastSeasonCard(),
          ),
        ],
      ), //
    );
  }
}

class _LastSeasonCard extends StatelessWidget {
  const _LastSeasonCard();

  @override
  Widget build(BuildContext context) {
    final TVDetailsViewModel model = context.watch<TVDetailsViewModel>();
    final LastEpisodeToAir? lastEpisode = context
        .select((TVDetailsViewModel model) => model.data.lastEpisodeToAir);
    if (lastEpisode == null) {
      return const SizedBox.shrink();
    }

    final String? stillPath = lastEpisode.stillPath;
    final String? backdropPath = model.data.backdropPath;
    final String name = lastEpisode.name ?? '';
    final int seasonNumber = lastEpisode.seasonNumber;
    final int episodeNumber = lastEpisode.episodeNumber;
    final String episodeType = lastEpisode.episodeType;
    final String overview = lastEpisode.overview ?? '';
    final int? releaseYear = lastEpisode.airDate?.year;
    final int rating = (lastEpisode.voteAverage * 10).round();

    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            if (stillPath != null)
              Image.network(
                Config.imageUrl(stillPath),
                width: double.infinity,
                fit: BoxFit.cover,
              )
            else if (backdropPath != null)
              Image.network(
                Config.imageUrl(backdropPath),
                width: double.infinity,
                fit: BoxFit.cover,
              )
            else
              const SizedBox.shrink(),
            if (episodeType == 'finale')
              const Text(
                'Final Episode',
                style: AppTextStyle.finalSeasonStyle,
              )
            else
              const SizedBox.shrink(),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Season $seasonNumber',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.boldBasicTextStyle,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Icon(
                Icons.star,
                color: AppColors.appBackgroundColor,
                size: 10,
              ),
            ),
            Text(
              'Episode $episodeNumber',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.boldBasicTextStyle,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.castTitleStyle,
            ),
            const SizedBox(width: 10),
            Text(
              '($releaseYear)',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.castNameStyle,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: overview != ''
                    ? const Text(
                        'Overview',
                        style: AppTextStyle.castTitleStyle,
                        textAlign: TextAlign.left,
                      )
                    : const SizedBox.shrink(),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: rating != 0
                        ? Stack(
                            children: <Widget>[
                              const ColoredBox(
                                color: AppColors.appBackgroundColor,
                                child: SizedBox(
                                  width: 100,
                                  height: 40,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Row(
                                  children: <Widget>[
                                    const Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Icon(
                                        Icons.star,
                                        color: AppColors.appTextColor,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Text(
                                      '$rating %',
                                      style: AppTextStyle.movieTitleStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            overview,
            style: AppTextStyle.basicTextStyle,
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
