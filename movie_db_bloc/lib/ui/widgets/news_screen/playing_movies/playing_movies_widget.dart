import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/constants/region_enum.dart';
import 'package:the_movie_db/library/make_data_structure/make_data_structure.dart';
import 'package:the_movie_db/types/types.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/widgets/elements/horizontal_movies_list.dart';
import 'package:the_movie_db/ui/widgets/elements/toggle_button_custom.dart';
import 'package:the_movie_db/ui/widgets/news_screen/playing_movies/playing_list_cubit.dart';

class PlayingMoviesWidget extends StatefulWidget {
  const PlayingMoviesWidget({super.key});

  @override
  State<PlayingMoviesWidget> createState() => _PlayingMoviesWidgetState();
}

class _PlayingMoviesWidgetState extends State<PlayingMoviesWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final PlayingListCubit cubit = context.read<PlayingListCubit>();
    final Locale locale = Localizations.localeOf(context);
    cubit.setupLocale(locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    final PlayingListCubit cubit = context.watch<PlayingListCubit>();
    final List<DataStructure> movies = MakeDataStructure.makeDataStructure(
      cubit.state.playingList,
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
                  'Now Playing',
                  style: AppTextStyle.newsTitleStyle,
                ),
              ),
              Expanded(
                flex: 4,
                child: ToggleButtonCustom<PlayingListCubit>(
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
