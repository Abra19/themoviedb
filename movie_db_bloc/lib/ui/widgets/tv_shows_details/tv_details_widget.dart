import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/ui/theme/app_colors.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/widgets/main_screen/main_screen_model.dart';
import 'package:the_movie_db/ui/widgets/tv_shows_details/tv_cast_widget.dart';
import 'package:the_movie_db/ui/widgets/tv_shows_details/tv_details_model.dart';
import 'package:the_movie_db/ui/widgets/tv_shows_details/tv_info_widget.dart';
import 'package:the_movie_db/ui/widgets/tv_shows_details/tv_production_widget.dart';

class TVDetailsWidget extends StatefulWidget {
  const TVDetailsWidget({super.key});

  @override
  State<TVDetailsWidget> createState() => _TVDetailsWidgetState();
}

class _TVDetailsWidgetState extends State<TVDetailsWidget> {
  @override
  void initState() {
    super.initState();
    final TVDetailsViewModel model = context.read<TVDetailsViewModel>();
    final MainScreenViewModel mainModel = context.read<MainScreenViewModel>();
    model.onSessionExpired = () => mainModel.onLogoutButtonPressed(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final TVDetailsViewModel model = context.read<TVDetailsViewModel>();
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
        child: _ShowBody(),
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget();

  @override
  Widget build(BuildContext context) {
    final String title =
        context.select((TVDetailsViewModel model) => model.data.name);
    return Text(
      title,
      style: AppTextStyle.movieTitleStyle,
    );
  }
}

class _ShowBody extends StatelessWidget {
  const _ShowBody();

  @override
  Widget build(BuildContext context) {
    final bool isLoading =
        context.select((TVDetailsViewModel model) => model.data.isLoading);
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
      children: const <Widget>[
        ShowInfoWidget(),
        SizedBox(height: 30),
        TVScreenCast(),
        TVProductionWidget(),
      ],
    );
  }
}
