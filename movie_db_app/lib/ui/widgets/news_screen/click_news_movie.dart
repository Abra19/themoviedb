import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/ui/widgets/news_screen/news_screen_model.dart';

class ClickNewsMovieWidget extends StatelessWidget {
  const ClickNewsMovieWidget({
    super.key,
    required this.index,
    required this.type,
  });
  final int index;
  final String type;

  @override
  Widget build(BuildContext context) {
    final NewsScreenViewModel model = context.read<NewsScreenViewModel>();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => model.onMovieClick(context, index, type),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
