import 'package:flutter/material.dart';
import 'package:the_movie_db/constants/movies_datas.dart';
import 'package:the_movie_db/constants/score_widget.dart';
import 'package:the_movie_db/domain/api_client/api_client.dart';
import 'package:the_movie_db/domain/entities/movie_details/movie_details.dart';
import 'package:the_movie_db/domain/entities/movie_details/movie_details_credits.dart';
import 'package:the_movie_db/domain/entities/movie_details/movie_details_video.dart';
import 'package:the_movie_db/library/providers/notify_provider.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';
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
    final MovieDetails? movie =
        NotifyProvider.watch<MovieDetailsModel>(context)?.movieDetails;
    final String? backdropPath = movie?.backdropPath;
    final String? posterPath = movie?.posterPath;
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: <Widget>[
          if (backdropPath != null)
            Image.network(ApiClient.imageUrl(backdropPath))
          else
            const SizedBox.shrink(),
          Positioned(
            top: 20,
            left: 20,
            bottom: 20,
            child: posterPath != null
                ? Image.network(
                    ApiClient.imageUrl(posterPath),
                    fit: BoxFit.cover,
                    height: 160,
                  )
                : const SizedBox.shrink(),
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
    final MovieDetails? movie =
        NotifyProvider.watch<MovieDetailsModel>(context)?.movieDetails;

    final String? movieTitle = movie?.title;
    String? movieYear = movie?.releaseDate?.year.toString();
    movieYear = movieYear != 'null' ? ' ($movieYear)' : '';

    return RichText(
      maxLines: 2,
      textAlign: TextAlign.center,
      text: TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: movieTitle ?? '',
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
    final MovieDetails? movie =
        NotifyProvider.watch<MovieDetailsModel>(context)?.movieDetails;
    final double? voteAverage = movie?.voteAverage;
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
        Container(width: 1, height: 15, color: AppColors.appInputBorderColor),
        const PlayTrailer(),
      ],
    );
  }
}

class PlayTrailer extends StatelessWidget {
  const PlayTrailer({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MovieDetailVideoResult>? results =
        NotifyProvider.watch<MovieDetailsModel>(context)
            ?.movieDetails
            ?.videos
            .results;
    if (results == null) {
      return const SizedBox.shrink();
    }

    final List<MovieDetailVideoResult> videos = results
        .where(
          (MovieDetailVideoResult video) =>
              video.type == 'Trailer' && video.site == 'YouTube',
        )
        .toList();
    final String? trailerKey = videos.isNotEmpty ? videos.first.key : null;
    return trailerKey != null
        ? TextButton(
            onPressed: () => Navigator.of(context).pushNamed(
              MainNavigationRouteNames.movieDetailsTrailer,
              arguments: trailerKey,
            ),
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
          )
        : const SizedBox.shrink();
  }
}

class _SummaryWidget extends StatelessWidget {
  const _SummaryWidget();

  @override
  Widget build(BuildContext context) {
    final MovieDetailsModel? model =
        NotifyProvider.watch<MovieDetailsModel>(context);
    if (model == null) {
      return const SizedBox.shrink();
    }
    String date = '';
    final DateTime? releaseDate = model.movieDetails?.releaseDate;
    if (releaseDate != null) {
      date = model.stringFromDate(releaseDate);
    }

    final List<ProductionCountry>? listCountries =
        model.movieDetails?.productionCountries;

    final String countries = listCountries == null || listCountries.isEmpty
        ? ''
        : '(${model.movieDetails?.productionCountries.join(', ')})';

    final int minutes = model.movieDetails?.runtime ?? 0;
    final String duration = '${minutes ~/ 60}h${minutes % 60}m';

    final List<Genre>? listGenres = model.movieDetails?.genres;
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
              '® $date $countries',
              style: AppTextStyle.movieDataStyle,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Icon(Icons.star, color: AppColors.appTextColor, size: 10),
            ),
            Text(duration, style: AppTextStyle.movieDataStyle),
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
    final MovieDetails? movie =
        NotifyProvider.watch<MovieDetailsModel>(context)?.movieDetails;
    if (movie == null) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Overview', style: AppTextStyle.movieTitleStyle),
        const SizedBox(height: 10),
        Text(
          movie.overview ?? '',
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
        NotifyProvider.watch<MovieDetailsModel>(context)?.movieDetails?.credits;
    if (credits == null || credits.crew.isEmpty) {
      return const SizedBox.shrink();
    }

    final List<CrewData> basicCrew = credits.crew
        .where((Crew el) => specialty.contains(el.job))
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
