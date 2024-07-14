import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/entities/movie_details/movie_details.dart';
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
      body: const ColoredBox(
        color: AppColors.appMovieInfoColor,
        child: _MovieBody(),
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
    return Text(
      model.movieDetails?.title ?? 'Loading ...',
      style: AppTextStyle.movieTitleStyle,
    );
  }
}

class _MovieBody extends StatelessWidget {
  const _MovieBody();

  @override
  Widget build(BuildContext context) {
    final MovieDetails? movie =
        NotifyProvider.watch<MovieDetailsModel>(context)?.movieDetails;
    if (movie == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
      children: const <Widget>[
        MovieInfoWidget(),
        SizedBox(height: 30),
        MovieScreenCast(),
      ],
    );
  }
}
