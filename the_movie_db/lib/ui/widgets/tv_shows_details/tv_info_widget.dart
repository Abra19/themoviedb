import 'package:flutter/material.dart';
import 'package:the_movie_db/config/config.dart';
import 'package:the_movie_db/constants/movies_datas.dart';
import 'package:the_movie_db/constants/score_widget.dart';
import 'package:the_movie_db/domain/entities/general/genre.dart';
import 'package:the_movie_db/domain/entities/general/production_country.dart';
import 'package:the_movie_db/domain/entities/movie_details/movie_details_credits.dart';
import 'package:the_movie_db/domain/entities/show_details/show_details.dart';
import 'package:the_movie_db/library/providers/notify_provider.dart';
import 'package:the_movie_db/ui/theme/app_colors.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/widgets/elements/radial_percent_widget.dart';
import 'package:the_movie_db/ui/widgets/tv_shows_details/tv_details_model.dart';

class ShowInfoWidget extends StatelessWidget {
  const ShowInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _TopPosterWidget(),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: _ShowNameWidget(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: _ScoreWidget(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: _SummaryWidget(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: _OverviewWidget(),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: _MovieCrewWidgets(),
          ),
        ],
      ),
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget();

  @override
  Widget build(BuildContext context) {
    final TVDetailsViewModel? model =
        NotifyProvider.watch<TVDetailsViewModel>(context);
    if (model == null) {
      return const SizedBox.shrink();
    }
    final ShowDetails? show = model.showDetails;
    final String? backdropPath = show?.backdropPath;
    final String? posterPath = show?.posterPath;
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: <Widget>[
          if (backdropPath != null)
            Image.network(Config.imageUrl(backdropPath))
          else
            const SizedBox.shrink(),
          Positioned(
            top: 20,
            left: 20,
            bottom: 20,
            child: posterPath != null
                ? Image.network(
                    Config.imageUrl(posterPath),
                    fit: BoxFit.cover,
                    height: 160,
                  )
                : const SizedBox.shrink(),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              onPressed: () => model.onFavoriteClick(context),
              icon: Icon(
                model.isFavorite ? Icons.favorite : Icons.favorite_outline,
              ),
              iconSize: 40,
              color: AppColors.appButtonsColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _ShowNameWidget extends StatelessWidget {
  const _ShowNameWidget();

  @override
  Widget build(BuildContext context) {
    final ShowDetails? show =
        NotifyProvider.watch<TVDetailsViewModel>(context)?.showDetails;

    final String? showTitle = show?.name;
    String? showYear = show?.firstAirDate?.year.toString();
    showYear = showYear != 'null' ? ' ($showYear)' : '';

    return RichText(
      maxLines: 2,
      textAlign: TextAlign.center,
      text: TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: showTitle ?? '',
            style: AppTextStyle.movieTitleStyle,
          ),
          TextSpan(
            text: showYear,
            style: AppTextStyle.movieDataStyle,
          ),
        ],
      ),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget();

  @override
  Widget build(BuildContext context) {
    final ShowDetails? show =
        NotifyProvider.watch<TVDetailsViewModel>(context)?.showDetails;
    final double? voteAverage = show?.voteAverage;
    final double percent = voteAverage != null ? voteAverage * 10 : 0.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        TextButton(
          onPressed: () {},
          child: Row(
            children: <Widget>[
              SizedBox(
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
              const SizedBox(width: 10),
              const Text(
                'User Score',
                style: AppTextStyle.movieDataStyle,
              ),
            ],
          ),
        ),
        const PlayTrailer(),
      ],
    );
  }
}

class PlayTrailer extends StatelessWidget {
  const PlayTrailer({super.key});

  @override
  Widget build(BuildContext context) {
    final TVDetailsViewModel? model =
        NotifyProvider.watch<TVDetailsViewModel>(context);
    final String? trailerKey = model?.trailerKey;

    return trailerKey != null && model != null
        ? Row(
            children: <Widget>[
              Container(
                width: 1,
                height: 15,
                color: AppColors.appInputBorderColor,
              ),
              TextButton(
                onPressed: () => model.showTrailer(context),
                child: const Row(
                  children: <Widget>[
                    Icon(
                      Icons.play_arrow,
                      color: AppColors.appTextColor,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Play Trailer',
                      style: AppTextStyle.movieDataStyle,
                    ),
                  ],
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}

class _SummaryWidget extends StatelessWidget {
  const _SummaryWidget();

  @override
  Widget build(BuildContext context) {
    final TVDetailsViewModel? model =
        NotifyProvider.watch<TVDetailsViewModel>(context);
    if (model == null) {
      return const SizedBox.shrink();
    }
    String date = '';
    final DateTime? releaseDate = model.showDetails?.firstAirDate;
    if (releaseDate != null) {
      date = model.stringFromDate(releaseDate);
    }

    final List<ProductionCountry>? listCountries =
        model.showDetails?.productionCountries;

    final String countries = listCountries == null || listCountries.isEmpty
        ? ''
        : '(${listCountries.join(', ')})';

    final int seasons = model.showDetails?.numberOfSeasons ?? 0;
    final int episodes = model.showDetails?.numberOfEpisodes ?? 0;

    final List<Genre>? listGenres = model.showDetails?.genres;
    final String genres = listGenres == null || listGenres.isEmpty
        ? ''
        : listGenres
            .map((Genre el) => el.name[0].toUpperCase() + el.name.substring(1))
            .join(', ');
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '® $date',
              style: AppTextStyle.movieDataStyle,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Icon(Icons.star, color: AppColors.appTextColor, size: 10),
            ),
            Text(
              countries,
              style: AppTextStyle.movieDataStyle,
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              seasons != 0 ? '$seasons seasons' : '',
              style: AppTextStyle.movieDataStyle,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Icon(Icons.star, color: AppColors.appTextColor, size: 10),
            ),
            Text(
              episodes != 0 ? '$episodes episodes' : '',
              style: AppTextStyle.movieDataStyle,
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  genres,
                  style: AppTextStyle.movieDataStyle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _OverviewWidget extends StatelessWidget {
  const _OverviewWidget();

  @override
  Widget build(BuildContext context) {
    final ShowDetails? show =
        NotifyProvider.watch<TVDetailsViewModel>(context)?.showDetails;
    if (show == null) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (show.tagline != null && show.tagline!.isNotEmpty)
          Column(
            children: <Widget>[
              Text(show.tagline!, style: AppTextStyle.movieTagStyle),
              const SizedBox(height: 10),
            ],
          )
        else
          const SizedBox.shrink(),
        if (show.overview != null && show.overview!.isNotEmpty)
          const Column(
            children: <Widget>[
              Text('Overview', style: AppTextStyle.movieTitleStyle),
              SizedBox(height: 10),
            ],
          )
        else
          const SizedBox.shrink(),
        Text(
          show.overview ?? '',
          style: AppTextStyle.movieDataStyle,
        ),
      ],
    );
  }
}

class _MovieCrewWidgets extends StatelessWidget {
  const _MovieCrewWidgets();

  @override
  Widget build(BuildContext context) {
    final MovieDetailsCredits? credits =
        NotifyProvider.watch<TVDetailsViewModel>(context)?.showDetails?.credits;

    if (credits == null || credits.crew.isEmpty) {
      return const SizedBox.shrink();
    }

    final List<CrewData> basicCrew = credits.crew
        .where((Crew el) => specialtySeries.contains(el.job))
        .map((Crew el) => CrewData(name: el.name, job: el.job))
        .fold(<String, List<String>>{},
            (Map<String, List<String>> acc, CrewData el) {
          acc[el.name] = acc[el.name] != null
              ? <String>[...acc[el.name]!, el.job]
              : <String>[el.job];
          return acc;
        })
        .entries
        .map(
          (MapEntry<String, List<String>> el) => CrewData(
            name: el.key,
            job: el.value.join(', '),
          ),
        )
        .toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      primary: false,
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        childAspectRatio: 2.2,
      ),
      itemCount: basicCrew.length,
      itemBuilder: (BuildContext context, int index) {
        final CrewData member = basicCrew[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              member.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.movieNameStyle,
            ),
            Text(
              member.job,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.movieDataStyle,
            ),
          ],
        );
      },
    );
  }
}
