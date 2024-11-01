import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/constants/period_enum.dart';
import 'package:the_movie_db/library/make_data_structure/make_data_structure.dart';
import 'package:the_movie_db/types/types.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/widgets/elements/horizontal_movies_list.dart';
import 'package:the_movie_db/ui/widgets/elements/toggle_button_custom.dart';
import 'package:the_movie_db/ui/widgets/news_screen/trended_movies/trended_list_cubit.dart';

class TrendedMoviesWidget extends StatefulWidget {
  const TrendedMoviesWidget({super.key});

  @override
  State<TrendedMoviesWidget> createState() => _TrendedMoviesWidgetState();
}

class _TrendedMoviesWidgetState extends State<TrendedMoviesWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final TrendedListCubit cubit = context.read<TrendedListCubit>();
    final Locale locale = Localizations.localeOf(context);
    cubit.setupLocale(locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    final TrendedListCubit cubit = context.watch<TrendedListCubit>();
    final List<DataStructure> movies = MakeDataStructure.makeDataStructure(
      cubit.state.trendedList,
      cubit.dateFormat,
    );
    final String message = cubit.state.errorMessage;
    final List<String> periodOptions = cubit.periodOptions;
    final List<bool> isSelectedPeriod = <bool>[
      cubit.state.selectedPeriod == PeriodType.day.name,
      cubit.state.selectedPeriod == PeriodType.week.name,
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
                  'In Trend',
                  style: AppTextStyle.newsTitleStyle,
                ),
              ),
              Expanded(
                child: ToggleButtonCustom<TrendedListCubit>(
                  model: cubit,
                  options: periodOptions,
                  isSelected: isSelectedPeriod,
                  tapFunction: (int index) => cubit.toggleSelectedPeriod(index),
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
