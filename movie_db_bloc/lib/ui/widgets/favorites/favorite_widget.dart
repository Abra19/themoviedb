import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/config/config.dart';
import 'package:the_movie_db/types/types.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/theme/card_movie_style.dart';
import 'package:the_movie_db/ui/widgets/elements/errors_widget.dart';
import 'package:the_movie_db/ui/widgets/elements/toggle_button_custom.dart';
import 'package:the_movie_db/ui/widgets/favorites/click_favorite_widget.dart';
import 'package:the_movie_db/ui/widgets/favorites/favorite_model.dart';

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final FavoriteViewModel model = context.read<FavoriteViewModel>();
    final Locale locale = Localizations.localeOf(context);
    model.setupLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    final FavoriteViewModel model = context.watch<FavoriteViewModel>();
    final String? error = model.errorMessage;
    final List<String> favoritesOptions = model.favoritesOptions;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 20,
          ),
          child: Row(
            children: <Widget>[
              const Expanded(
                child: Text(
                  'Your favorites',
                  style: AppTextStyle.newsTitleStyle,
                ),
              ),
              Expanded(
                child: ToggleButtonCustom<FavoriteViewModel>(
                  model: model,
                  options: favoritesOptions,
                  isSelected: model.isSelectedFavorites,
                  tapFunction: (int index) =>
                      model.toggleSelectedFavorites(index),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Stack(
              children: <Widget>[
                ErrorsWidget(message: error),
                _FavoriteListBuilder(model.favorites),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FavoriteListBuilder extends StatelessWidget {
  const _FavoriteListBuilder(this.movies);

  final List<MovieListRowData> movies;

  @override
  Widget build(BuildContext context) {
    final FavoriteViewModel model = context.watch<FavoriteViewModel>();
    final int length = model.favorites.length;
    return ListView.builder(
      padding: const EdgeInsets.only(top: 16),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: length,
      itemExtent: 163,
      itemBuilder: (BuildContext context, int index) {
        model.showFavoritesAtIndex(index);
        final MovieListRowData movie = model.favorites[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: AppMovieCardStyle.cardDecoration,
                clipBehavior: Clip.hardEdge,
                child: _FavoriteListRow(index: index, movie: movie),
              ),
              ClickFavoriteWidget(
                index: movie.id,
                type: movie.mediaType,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FavoriteListRow extends StatelessWidget {
  const _FavoriteListRow({required this.index, required this.movie});

  final int index;
  final MovieListRowData movie;

  @override
  Widget build(BuildContext context) {
    final String? posterPath = movie.posterPath;
    final String? title = movie.title ?? movie.name;
    return Row(
      children: <Widget>[
        if (posterPath != null)
          Image.network(
            Config.imageUrl(posterPath),
            width: 95,
          ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10),
              if (title != null)
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.boldBasicTextStyle,
                ),
              const SizedBox(height: 5),
              Text(
                movie.releaseDate ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.movieDataTextStyle,
              ),
              const SizedBox(height: 20),
              Text(
                movie.overview ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
