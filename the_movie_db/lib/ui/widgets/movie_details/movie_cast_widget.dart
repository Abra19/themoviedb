import 'package:flutter/material.dart';
import 'package:the_movie_db/constants/actors_datas.dart';
import 'package:the_movie_db/constants/movies_datas.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';
import 'package:the_movie_db/ui/theme/app_colors.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/theme/card_movie_style.dart';

class MovieScreenCast extends StatelessWidget {
  const MovieScreenCast({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    void onActorClick(int id) {
      Navigator.of(context).pushNamed(
        MainNavigationRouteNames.movieDetailsActor,
        arguments: id,
      );
    }

    return ColoredBox(
      color: AppColors.appScreenCastColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Series Cast', style: AppTextStyle.castTitleStyle),
            const SizedBox(height: 10),
            SizedBox(
              height: 400,
              child: Scrollbar(
                child: ListView(
                  itemExtent: 150,
                  scrollDirection: Axis.horizontal,
                  children: movie.casts.map((int el) {
                    final Actor actor =
                        actorsData.firstWhere((Actor actor) => actor.id == el);
                    return TextButton(
                      onPressed: () => onActorClick(el),
                      child: DecoratedBox(
                        decoration: AppMovieCardStyle.cardDecoration,
                        child: ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.circular(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Image(
                                image: AssetImage(actor.image),
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  actor.name,
                                  style: AppTextStyle.castNameStyle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  maxLines: 10,
                                  overflow: TextOverflow.ellipsis,
                                  actor.description,
                                  style: AppTextStyle.castDescriptionStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ), //
    );
  }
}
