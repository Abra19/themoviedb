import 'package:flutter/material.dart';
import 'package:the_movie_db/library/providers/notify_provider.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/widgets/elements/horizontal_movies_list.dart';
import 'package:the_movie_db/ui/widgets/elements/toggle_button_custom.dart';
import 'package:the_movie_db/ui/widgets/news_screen/news_screen_model.dart';

class NewsScreenWidget extends StatefulWidget {
  const NewsScreenWidget({super.key});

  @override
  State<NewsScreenWidget> createState() => _NewsScreenWidgetState();
}

class _NewsScreenWidgetState extends State<NewsScreenWidget> {
  @override
  Widget build(BuildContext context) {
    final NewsScreenModel? model =
        NotifyProvider.watch<NewsScreenModel>(context);
    if (model == null) {
      return const SizedBox.shrink();
    }

    final List<String> periodOptions = model.periodOptions;
    final List<String> regionOptions = model.regionOptions;

    return model.isLoaded
        ? ListView(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      child:
                          Text('In Trend', style: AppTextStyle.newsTitleStyle),
                    ),
                    Expanded(
                      child: ToggleButtonCustom(
                        model: model,
                        options: periodOptions,
                        isSelected: model.isSelectedDay,
                        tapFunction: (int index) =>
                            model.toggleSelectedPeriod(index),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: HorizontalMoviesList(
                  model: model,
                  movies: model.trendedMovies,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      flex: 3,
                      child: Text(
                        'Coming soon',
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
                child:
                    HorizontalMoviesList(model: model, movies: model.newMovies),
              ),
              const SizedBox(height: 20),
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
                  model: model,
                  movies: model.playingMovies,
                ),
              ),
              const SizedBox(height: 20),
            ],
          )
        : const Center(child: CircularProgressIndicator());
  }
}
