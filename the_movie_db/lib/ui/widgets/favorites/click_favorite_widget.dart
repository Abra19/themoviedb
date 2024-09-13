import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    final FavoriteViewModel model = context.read<FavoriteViewModel>();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => model.onFavoriteClick(context, index, type),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
