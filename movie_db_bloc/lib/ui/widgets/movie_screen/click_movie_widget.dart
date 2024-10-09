import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';
import 'package:the_movie_db/ui/widgets/movie_screen/movie_list_cubit.dart';

class ClickMovieWidget extends StatelessWidget {
  const ClickMovieWidget({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    void onMovieClick(int movieId) {
      Navigator.of(context).pushNamed(
        MainNavigationRouteNames.movieDetails,
        arguments: movieId,
      );
    }

    final MovieListCubit cubit = context.read<MovieListCubit>();
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onMovieClick(cubit.state.movies[index].id),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
