import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/constants/region_enum.dart';
import 'package:the_movie_db/library/make_data_structure/make_data_structure.dart';
import 'package:the_movie_db/types/types.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/widgets/elements/horizontal_movies_list.dart';
import 'package:the_movie_db/ui/widgets/elements/toggle_button_custom.dart';
import 'package:the_movie_db/ui/widgets/news_screen/new_movies/new_movies_list_cubit.dart';

class NewMoviesWidget extends StatefulWidget {
  const NewMoviesWidget({super.key});

  @override
  State<NewMoviesWidget> createState() => _NewMoviesWidgetState();
}

class _NewMoviesWidgetState extends State<NewMoviesWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final NewMoviesListCubit cubit = context.read<NewMoviesListCubit>();
    final Locale locale = Localizations.localeOf(context);
    cubit.setupLocale(locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    final NewMoviesListCubit cubit = context.watch<NewMoviesListCubit>();
    final List<DataStructure> movies = MakeDataStructure.makeDataStructure(
      cubit.state.newMoviesList,
      cubit.dateFormat,
    );
    final String message = cubit.state.errorMessage;
    final List<String> regionOptions = cubit.regionOptions;
    final List<bool> isSelectedRegion = <bool>[
      cubit.state.selectedRegion == RegionType.ru.name,
      cubit.state.selectedRegion == RegionType.eu.name,
      cubit.state.selectedRegion == RegionType.us.name,
    ];

    return Column(
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
                child: ToggleButtonCustom<NewMoviesListCubit>(
                  model: cubit,
                  options: regionOptions,
                  isSelected: isSelectedRegion,
                  tapFunction: (int index) => cubit.toggleSelectedRegion(index),
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
    );
  }
}
