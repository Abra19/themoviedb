import 'package:flutter/material.dart';
import 'package:the_movie_db/library/providers/notify_provider.dart';
import 'package:the_movie_db/ui/widgets/movie_screen/movies_widget_model.dart';

class ClickMovieWidget extends StatelessWidget {
  const ClickMovieWidget({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    final MoviesWidgetModel? model =
        NotifyProvider.read<MoviesWidgetModel>(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => model?.onMovieClick(context, index),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
