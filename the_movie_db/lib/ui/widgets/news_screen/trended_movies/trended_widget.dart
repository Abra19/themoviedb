import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/types/types.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/widgets/elements/horizontal_movies_list.dart';
import 'package:the_movie_db/ui/widgets/elements/toggle_button_custom.dart';
import 'package:the_movie_db/ui/widgets/news_screen/trended_movies/trended_view_model.dart';

class TrendedMoviesWidget extends StatefulWidget {
  const TrendedMoviesWidget({super.key});

  @override
  State<TrendedMoviesWidget> createState() => _TrendedMoviesWidgetState();
}

class _TrendedMoviesWidgetState extends State<TrendedMoviesWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final TrendedViewModel model = context.read<TrendedViewModel>();
    model.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    final TrendedViewModel model = context.watch<TrendedViewModel>();
    final List<DataStructure> movies = model.makeDataStructure();
    final String message = model.errorMessage;
    final List<String> periodOptions = model.periodOptions;

    return model.isTrendedLoaded
        ? Column(
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
                        'In Trend',
                        style: AppTextStyle.newsTitleStyle,
                      ),
                    ),
                    Expanded(
                      child: ToggleButtonCustom<TrendedViewModel>(
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
                  datas: movies,
                  message: message,
                ),
              ),
            ],
          )
        : const Column(
            children: <Widget>[
              SizedBox(height: 50),
              Center(child: CircularProgressIndicator()),
            ],
          );
  }
}
