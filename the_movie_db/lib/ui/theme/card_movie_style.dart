import 'package:flutter/material.dart';
import 'package:the_movie_db/ui/theme/app_colors.dart';

abstract class AppMovieCardStyle {
  static BoxDecoration cardDecoration = BoxDecoration(
    color: AppColors.appMovieCardColor,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: AppColors.appMovieCardBorderColor),
    boxShadow: const <BoxShadow>[
      BoxShadow(
        color: AppColors.appMovieCardShadowColor,
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
  );

  static InputDecoration findFieldDecorationMovie = InputDecoration(
    filled: true,
    fillColor: Colors.white.withAlpha(235),
    border: const OutlineInputBorder(),
    labelText: 'Find movie',
  );

  static InputDecoration findFieldDecorationShow = InputDecoration(
    filled: true,
    fillColor: Colors.white.withAlpha(235),
    border: const OutlineInputBorder(),
    labelText: 'Find TV show',
  );

  static var findFieldDecorationTVShow;
}
