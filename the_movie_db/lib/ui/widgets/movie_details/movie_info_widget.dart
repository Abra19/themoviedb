import 'package:flutter/material.dart';
import 'package:the_movie_db/constants/movies_datas.dart';
import 'package:the_movie_db/ui/theme/app_colors.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/widgets/elements/radial_percent_widget.dart';

class MovieInfoWidget extends StatelessWidget {
  const MovieInfoWidget({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _TopPosterWidget(movie: movie),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: _MovieNameWidget(movie: movie),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: _ScoreWidget(movie: movie),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: _SummaryWidget(movie: movie),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: _OverviewWidget(movie: movie),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: _MovieActorsWidgets(movie: movie),
        ),
      ],
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image(
          image: AssetImage(movie.bigImage),
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 20,
          left: 20,
          bottom: 20,
          child: Image(
            image: AssetImage(movie.image),
            fit: BoxFit.cover,
            height: 160,
          ),
        ),
      ],
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({
    required this.movie,
  });
  final Movie movie;
  static const double percent = 72;
  static const double lineWidth = 3.0;
  static const Color lineColor = AppColors.appProgressBarLineColor;
  static const Color fillColor = AppColors.appProgressBarFillColor;
  static const Color freeColor = AppColors.appProgressBarFreeColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        TextButton(
          onPressed: () {},
          child: const Row(
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
              SizedBox(width: 10),
              Text(
                'User Score',
                style: AppTextStyle.movieDataStyle,
              ),
            ],
          ),
        ),
        Container(width: 1, height: 15, color: AppColors.appInputBorderColor),
        TextButton(
          onPressed: () {},
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
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 2,
      textAlign: TextAlign.center,
      text: TextSpan(
        children: <InlineSpan>[
          TextSpan(text: movie.title, style: AppTextStyle.movieTitleStyle),
          TextSpan(
            text: ' (${movie.data})',
            style: AppTextStyle.movieDataStyle,
          ),
        ],
      ),
    );
  }
}

class _SummaryWidget extends StatelessWidget {
  const _SummaryWidget({required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '® ${movie.fullData} (${movie.country})',
              style: AppTextStyle.movieDataStyle,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Icon(Icons.star, color: AppColors.appTextColor, size: 10),
            ),
            Text(movie.duration, style: AppTextStyle.movieDataStyle),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  movie.genre,
                  style: AppTextStyle.movieDataStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
  const _OverviewWidget({required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Overview', style: AppTextStyle.movieTitleStyle),
        const SizedBox(height: 10),
        Text(
          movie.description,
          style: AppTextStyle.movieDataStyle,
        ),
      ],
    );
  }
}

class _MovieActorsWidgets extends StatelessWidget {
  const _MovieActorsWidgets({required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    movie.director,
                    style: AppTextStyle.movieTitleStyle,
                  ),
                  const Text(
                    'Director',
                    style: AppTextStyle.movieDataStyle,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    movie.actorOne,
                    style: AppTextStyle.movieTitleStyle,
                  ),
                  const Text(
                    'ScreenPlay',
                    style: AppTextStyle.movieDataStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    movie.novel,
                    style: AppTextStyle.movieTitleStyle,
                  ),
                  const Text(
                    'Novel',
                    style: AppTextStyle.movieDataStyle,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    movie.actorTwo,
                    style: AppTextStyle.movieTitleStyle,
                  ),
                  const Text(
                    'ScreenPlay',
                    style: AppTextStyle.movieDataStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
