import 'package:flutter/material.dart';

class PlayingMoviesWidget extends StatefulWidget {
  const PlayingMoviesWidget({super.key});

  @override
  State<PlayingMoviesWidget> createState() => _PlayingMoviesWidgetState();
}

class _PlayingMoviesWidgetState extends State<PlayingMoviesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

    //   final NewsScreenViewModel model = context.read<NewsScreenViewModel>();
    //   final List<String> periodOptions = model.periodOptions;
    //   final List<String> regionOptions = model.regionOptions;

    //   return model.isLoaded
    //       ? ListView(
    //           children: <Widget>[
    //             Padding(
    //               padding:
    //                   const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
    //               child: Row(
    //                 children: <Widget>[
    //                   const Expanded(
    //                     child:
    //                         Text('In Trend', style: AppTextStyle.newsTitleStyle),
    //                   ),
    //                   Expanded(
    //                     child: ToggleButtonCustom(
    //                       model: model,
    //                       options: periodOptions,
    //                       isSelected: model.isSelectedDay,
    //                       tapFunction: (int index) =>
    //                           model.toggleSelectedPeriod(index),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             const SizedBox(height: 10),
    //             Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 10.0),
    //               child: HorizontalMoviesList(
    //                 model: model,
    //                 movies: model.trendedMovies,
    //               ),
    //             ),
    //             const SizedBox(height: 20),
    //             Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 10.0),
    //               child: Row(
    //                 children: <Widget>[
    //                   const Expanded(
    //                     flex: 3,
    //                     child: Text(
    //                       'Coming soon',
    //                       style: AppTextStyle.newsTitleStyle,
    //                     ),
    //                   ),
    //                   Expanded(
    //                     flex: 4,
    //                     child: ToggleButtonCustom(
    //                       model: model,
    //                       options: regionOptions,
    //                       isSelected: model.isSelectedRegionComing,
    //                       tapFunction: (int index) =>
    //                           model.toggleSelectedRegion(index, 'Coming'),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             const SizedBox(height: 10),
    //             Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 10.0),
    //               child:
    //                   HorizontalMoviesList(model: model, movies: model.newMovies),
    //             ),
    //             const SizedBox(height: 20),
    //             Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 10.0),
    //               child: Row(
    //                 children: <Widget>[
    //                   const Expanded(
    //                     flex: 3,
    //                     child: Text(
    //                       'Now Playing',
    //                       style: AppTextStyle.newsTitleStyle,
    //                     ),
    //                   ),
    //                   Expanded(
    //                     flex: 4,
    //                     child: ToggleButtonCustom(
    //                       model: model,
    //                       options: regionOptions,
    //                       isSelected: model.isSelectedRegionPlaying,
    //                       tapFunction: (int index) =>
    //                           model.toggleSelectedRegion(index, 'Playing'),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             const SizedBox(height: 10),
    //             Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 10.0),
    //               child: HorizontalMoviesList(
    //                 model: model,
    //                 movies: model.playingMovies,
    //               ),
    //             ),
    //             const SizedBox(height: 20),
    //           ],
    //         )
    //       : const Center(child: CircularProgressIndicator());
    // }