import 'package:flutter/material.dart';
import 'package:the_movie_db/ui/theme/app_colors.dart';

abstract class AppButtonStyle {
  static ButtonStyle linkButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: AppColors.appButtonsColor,
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
    side: BorderSide.none,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );

  static ButtonStyle loginButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.appButtonsColor,
    foregroundColor: AppColors.appTextColor,
    overlayColor: AppColors.appButtonOverlayColor,
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );
}
