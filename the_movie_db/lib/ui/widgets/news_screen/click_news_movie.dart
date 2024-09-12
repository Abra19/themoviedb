import 'package:flutter/material.dart';
import 'package:the_movie_db/library/providers/notify_provider.dart';
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
    final NewsScreenViewModel? model =
        NotifyProvider.read<NewsScreenViewModel>(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => model?.onMovieClick(context, index, type),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
