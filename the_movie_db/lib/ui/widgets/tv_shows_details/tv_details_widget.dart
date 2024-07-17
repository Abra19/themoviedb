import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/entities/show_details/show_details.dart';
import 'package:the_movie_db/library/providers/notify_provider.dart';
import 'package:the_movie_db/ui/theme/app_colors.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    final TVDetailsModel? model = NotifyProvider.read<TVDetailsModel>(context);
    model?.setupLocale(context);
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
    final TVDetailsModel? model = NotifyProvider.watch<TVDetailsModel>(context);
    if (model == null) {
      return const SizedBox.shrink();
    }
    return Text(
      model.showDetails?.name ?? 'Loading ...',
      style: AppTextStyle.movieTitleStyle,
    );
  }
}

class _ShowBody extends StatelessWidget {
  const _ShowBody();

  @override
  Widget build(BuildContext context) {
    final ShowDetails? show =
        NotifyProvider.watch<TVDetailsModel>(context)?.showDetails;
    if (show == null) {
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
