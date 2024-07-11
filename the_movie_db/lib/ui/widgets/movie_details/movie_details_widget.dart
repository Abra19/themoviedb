import 'package:flutter/material.dart';
import 'package:the_movie_db/constants/movies_datas.dart';
import 'package:the_movie_db/library/providers/notify_provider.dart';
import 'package:the_movie_db/ui/theme/app_colors.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/widgets/movie_details/movie_cast_widget.dart';
import 'package:the_movie_db/ui/widgets/movie_details/movie_details_model.dart';
import 'package:the_movie_db/ui/widgets/movie_details/movie_info_widget.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({super.key});

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    NotifyProvider.read<MovieDetailsModel>(context)?.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _TitleWidget(),
      ),
      body: ColoredBox(
        color: AppColors.appMovieInfoColor,
        child: ListView(
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            // MovieInfoWidget(movie: movie),
            // MovieScreenCast(movie: movie),
          ],
        ),
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget();

  @override
  Widget build(BuildContext context) {
    final MovieDetailsModel? model =
        NotifyProvider.watch<MovieDetailsModel>(context);
    if (model == null) {
      return const SizedBox.shrink();
    }
    return Text(model.movieDetails?.title ?? '',
        style: AppTextStyle.movieTitleStyle);
  }
}
