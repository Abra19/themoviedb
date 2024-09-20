import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/config/config.dart';
import 'package:the_movie_db/constants/score_widget.dart';
import 'package:the_movie_db/domain/server_entities/movie_details/movie_details_credits.dart';
import 'package:the_movie_db/types/types.dart';
import 'package:the_movie_db/ui/theme/app_colors.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/widgets/elements/radial_percent_widget.dart';
import 'package:the_movie_db/ui/widgets/movie_details/movie_details_model.dart';

class MovieInfoWidget extends StatelessWidget {
  const MovieInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _TopPosterWidget(),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: _MovieNameWidget(),
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
    final MovieDetailsViewModel model = context.watch<MovieDetailsViewModel>();

    final MovieDetailsData movie = model.data;
    final String? backdropPath = movie.backdropPath;
    final String? posterPath = movie.posterPath;
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: <Widget>[
          if (backdropPath != null)
            Image.network(Config.imageUrl(backdropPath)),
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
              onPressed: () => model.onFavoriteClick(model.movieId),
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

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget();

  @override
  Widget build(BuildContext context) {
    final MovieDetailsData movie =
        context.select((MovieDetailsViewModel model) => model.data);

    final String movieTitle = movie.title;
    final String movieYear = movie.releaseYear;

    return RichText(
      maxLines: 2,
      textAlign: TextAlign.center,
      text: TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: movieTitle,
            style: AppTextStyle.movieTitleStyle,
          ),
          TextSpan(
            text: movieYear,
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
    final double percent =
        context.select((MovieDetailsViewModel model) => model.data.voteAverage);

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
        // const PlayTrailer(),
      ],
    );
  }
}

class PlayTrailer extends StatelessWidget {
  const PlayTrailer({super.key});

  @override
  Widget build(BuildContext context) {
    final MovieDetailsViewModel model = context.watch<MovieDetailsViewModel>();

    final String? trailerKey = model.trailerKey;

    return trailerKey != null
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
    final MovieDetailsData movie =
        context.select((MovieDetailsViewModel model) => model.data);

    final String date = movie.releaseDate;
    final String countries = movie.countries;
    final String duration = movie.runtime;
    final String genres = movie.genres;

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Text(
                '® $date $countries',
                style: AppTextStyle.movieDataStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Icon(
                      Icons.star,
                      color: AppColors.appTextColor,
                      size: 10,
                    ),
                  ),
                  Text(duration, style: AppTextStyle.movieDataStyle),
                ],
              ),
            ),
          ],
        ),
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
    final String overview =
        context.select((MovieDetailsViewModel model) => model.data.overview);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (overview.isNotEmpty)
          const Column(
            children: <Widget>[
              Text('Overview', style: AppTextStyle.movieTitleStyle),
              SizedBox(height: 10),
            ],
          )
        else
          const SizedBox.shrink(),
        Text(
          overview,
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
    final List<CrewData> basicCrew = context.select(
      (MovieDetailsViewModel model) => model.data.crew,
    );
    if (basicCrew.isEmpty) {
      return const SizedBox.shrink();
    }

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
