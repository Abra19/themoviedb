import 'package:flutter/material.dart';
import 'package:the_movie_db/library/providers/notify_provider.dart';
import 'package:the_movie_db/ui/widgets/favorites/favorite_model.dart';

class ClickFavoriteWidget extends StatelessWidget {
  const ClickFavoriteWidget({
    super.key,
    required this.index,
    required this.type,
  });
  final int index;
  final String type;

  @override
  Widget build(BuildContext context) {
    final FavoriteViewModel? model =
        NotifyProvider.read<FavoriteViewModel>(context);
    if (model == null) {
      return const SizedBox.shrink();
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => model.onFavoriteClick(context, index, type),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
