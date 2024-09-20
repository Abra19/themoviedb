import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/ui/theme/app_colors.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/widgets/main_screen/main_screen_model.dart';
import 'package:the_movie_db/ui/widgets/movie_details/movie_details_model.dart';

import 'package:the_movie_db/ui/widgets/movie_details/movie_cast_widget.dart';
import 'package:the_movie_db/ui/widgets/movie_details/movie_info_widget.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({super.key});

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  void initState() {
    super.initState();
    final MovieDetailsViewModel model = context.read<MovieDetailsViewModel>();
    final MainScreenViewModel mainModel = context.read<MainScreenViewModel>();
    model.onSessionExpired = () => mainModel.onLogoutButtonPressed(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final MovieDetailsViewModel model = context.read<MovieDetailsViewModel>();
    final Locale locale = Localizations.localeOf(context);
    model.setupLocale(locale);
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
    final String title = context.select(
      (MovieDetailsViewModel model) => model.data.title,
    );

    return Text(
      title,
      style: AppTextStyle.movieTitleStyle,
    );
  }
}

class _MovieBody extends StatelessWidget {
  const _MovieBody();

  @override
  Widget build(BuildContext context) {
    final bool isLoading =
        context.select((MovieDetailsViewModel model) => model.data.isLoading);
    if (isLoading) {
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
