import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/config/config.dart';
import 'package:the_movie_db/domain/server_entities/movie_details/movie_details_credits.dart';
import 'package:the_movie_db/ui/theme/app_colors.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/theme/card_movie_style.dart';
import 'package:the_movie_db/ui/widgets/movie_details/movie_details_model.dart';

class MovieScreenCast extends StatelessWidget {
  const MovieScreenCast({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: AppColors.appScreenCastColor,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Movie Cast', style: AppTextStyle.castTitleStyle),
            SizedBox(height: 10),
            SizedBox(
              height: 270,
              child: Scrollbar(
                child: _ActorsList(),
              ),
            ),
          ],
        ),
      ), //
    );
  }
}

class _ActorsList extends StatelessWidget {
  const _ActorsList();

  @override
  Widget build(BuildContext context) {
    final MovieDetailsViewModel model = context.watch<MovieDetailsViewModel>();
    final List<Cast> cast = model.data.cast;
    if (cast.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView(
      itemExtent: 150,
      scrollDirection: Axis.horizontal,
      children: cast.map((Cast el) {
        return TextButton(
          onPressed: () => model.onActorClick(context, el.id),
          child: DecoratedBox(
            decoration: AppMovieCardStyle.cardDecoration,
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (el.profilePath != null)
                    AspectRatio(
                      aspectRatio: 138 / 175,
                      child: Image.network(
                        Config.imageUrl(el.profilePath!),
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    const SizedBox.shrink(),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      el.name,
                      style: AppTextStyle.castNameStyle,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        el.character,
                        style: AppTextStyle.castDescriptionStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
