import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/types/types.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/widgets/elements/horizontal_movies_list.dart';
import 'package:the_movie_db/ui/widgets/elements/toggle_button_custom.dart';
import 'package:the_movie_db/ui/widgets/news_screen/playing_movies/playing_view_model.dart';

class PlayingMoviesWidget extends StatefulWidget {
  const PlayingMoviesWidget({super.key});

  @override
  State<PlayingMoviesWidget> createState() => _PlayingMoviesWidgetState();
}

class _PlayingMoviesWidgetState extends State<PlayingMoviesWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final PlayingMoviesViewModel model = context.read<PlayingMoviesViewModel>();
    model.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    final PlayingMoviesViewModel model =
        context.watch<PlayingMoviesViewModel>();
    final List<DataStructure> movies = model.makeDataStructure();
    final String message = model.errorMessage;
    final List<String> regionOptions = model.regionOptions;

    return model.isPlayingLoaded
        ? Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      flex: 3,
                      child: Text(
                        'Now Playing',
                        style: AppTextStyle.newsTitleStyle,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: ToggleButtonCustom(
                        model: model,
                        options: regionOptions,
                        isSelected: model.isSelectedRegion,
                        tapFunction: (int index) =>
                            model.toggleSelectedRegion(index),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: HorizontalMoviesList(
                  datas: movies,
                  message: message,
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
