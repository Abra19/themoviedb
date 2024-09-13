import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/types/types.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/widgets/elements/horizontal_movies_list.dart';
import 'package:the_movie_db/ui/widgets/elements/toggle_button_custom.dart';
import 'package:the_movie_db/ui/widgets/news_screen/new_movies/new_movies_view_model.dart';

class NewMoviesWidget extends StatefulWidget {
  const NewMoviesWidget({super.key});

  @override
  State<NewMoviesWidget> createState() => _NewMoviesWidgetState();
}

class _NewMoviesWidgetState extends State<NewMoviesWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final NewMoviesViewModel model = context.read<NewMoviesViewModel>();
    model.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    final NewMoviesViewModel model = context.watch<NewMoviesViewModel>();
    final List<DataStructure> movies = model.makeDataStructure();
    final String message = model.errorMessage;
    final List<String> regionOptions = model.regionOptions;

    return model.isNewLoaded
        ? Column(
            children: <Widget>[
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
                      child: ToggleButtonCustom<NewMoviesViewModel>(
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
