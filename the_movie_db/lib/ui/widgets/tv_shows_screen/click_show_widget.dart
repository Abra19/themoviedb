import 'package:flutter/material.dart';
import 'package:the_movie_db/library/providers/notify_provider.dart';
import 'package:the_movie_db/ui/widgets/tv_shows_screen/tv_shows_model.dart';

class ClickShowWidget extends StatelessWidget {
  const ClickShowWidget({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    final TVShowsViewModel? model =
        NotifyProvider.read<TVShowsViewModel>(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => model?.onShowClick(context, index),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
