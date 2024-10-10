import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';
import 'package:the_movie_db/ui/widgets/tv_shows_screen/tv_shows_list_cubit.dart';

class ClickShowWidget extends StatelessWidget {
  const ClickShowWidget({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    void onShowClick(int showId) {
      Navigator.of(context).pushNamed(
        MainNavigationRouteNames.tvDetails,
        arguments: showId,
      );
    }

    final ShowListCubit cubit = context.read<ShowListCubit>();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onShowClick(cubit.state.shows[index].id),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
