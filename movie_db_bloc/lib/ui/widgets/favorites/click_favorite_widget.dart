import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/constants/media_type_enum.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';
import 'package:the_movie_db/ui/widgets/favorites/favorite_list_cubit.dart';

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
    void onFavoriteClick(int id, String type) {
      if (type == MediaType.tv.name) {
        Navigator.of(context).pushNamed(
          MainNavigationRouteNames.tvDetails,
          arguments: id,
        );
      } else {
        Navigator.of(context).pushNamed(
          MainNavigationRouteNames.movieDetails,
          arguments: id,
        );
      }
    }

    final FavoriteListCubit cubit = context.read<FavoriteListCubit>();

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {
          return onFavoriteClick(
            cubit.state.favorites[index].id,
            type,
          );
        },
      ),
    );
  }
}
