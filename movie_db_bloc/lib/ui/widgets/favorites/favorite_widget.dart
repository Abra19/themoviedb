import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/config/config.dart';
import 'package:the_movie_db/constants/media_type_enum.dart';
import 'package:the_movie_db/types/types.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/theme/card_movie_style.dart';
import 'package:the_movie_db/ui/widgets/elements/errors_widget.dart';
import 'package:the_movie_db/ui/widgets/elements/toggle_button_custom.dart';
import 'package:the_movie_db/ui/widgets/favorites/click_favorite_widget.dart';
import 'package:the_movie_db/ui/widgets/favorites/favorite_list_cubit.dart';

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final FavoriteListCubit cubit = context.read<FavoriteListCubit>();
    final Locale locale = Localizations.localeOf(context);
    cubit.setupLocale(locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    final FavoriteListCubit cubit = context.watch<FavoriteListCubit>();
    final String error = cubit.errorMessage;
    final List<String> favoritesOptions = cubit.favoritesOptions;
    final List<bool> isSelectedFavorites = <bool>[
      cubit.state.selectedType == MediaType.movie.name,
      cubit.state.selectedType == MediaType.tv.name,
    ];

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
                child: ToggleButtonCustom<FavoriteListCubit>(
                  model: cubit,
                  options: favoritesOptions,
                  isSelected: isSelectedFavorites,
                  tapFunction: (int index) =>
                      cubit.toggleSelectedFavorites(index),
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
                _FavoriteListBuilder(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FavoriteListBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FavoriteListCubit cubit = context.watch<FavoriteListCubit>();
    final List<MovieListRowData> favorites = cubit.state.favorites;
    final int length = favorites.length;
    return ListView.builder(
      padding: const EdgeInsets.only(top: 16),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: length,
      itemExtent: 163,
      itemBuilder: (BuildContext context, int index) {
        cubit.showFavoritesAtIndex(index);
        final MovieListRowData movie = favorites[index];
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
                index: index,
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
  const _FavoriteListRow({
    required this.index,
    required this.movie,
  });

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
