import 'package:flutter/material.dart';
import 'package:the_movie_db/ui/theme/app_colors.dart';

abstract class AppTextStyle {
  static const double basicTextSizeStyle = 16.0;

  static const TextStyle basicTextStyle = TextStyle(
    fontSize: basicTextSizeStyle,
    color: AppColors.appBasicTextColor,
  );

  static const TextStyle formTextStyle = TextStyle(
    fontSize: basicTextSizeStyle,
    color: AppColors.appSupTextColor,
  );

  static const TextStyle boldBasicTextStyle = TextStyle(
    fontSize: basicTextSizeStyle,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle movieDataTextStyle = TextStyle(
    fontSize: 14,
    color: AppColors.appInputBorderColor,
  );

  static const TextStyle movieDataNewsTextStyle = TextStyle(
    fontSize: 12,
    color: AppColors.appInputBorderColor,
  );

  static const TextStyle likesPercentageTextStyle = TextStyle(
    color: AppColors.appTextColor,
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle movieTitleStyle = TextStyle(
    color: AppColors.appTextColor,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle movieNameStyle = TextStyle(
    color: AppColors.appTextColor,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle movieDataStyle = TextStyle(
    color: AppColors.appTextColor,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle movieTagStyle = TextStyle(
    color: Color.fromARGB(255, 190, 182, 182),
    fontSize: 18,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle castTitleStyle = TextStyle(
    color: AppColors.appBackgroundColor,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle castBirthdayStyle = TextStyle(
    color: AppColors.appBackgroundColor,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle castNameStyle = TextStyle(
    color: AppColors.appBackgroundColor,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle castDescriptionStyle = TextStyle(
    color: AppColors.appBackgroundColor,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle newsMoviesTitleStyle = TextStyle(
    color: AppColors.appBackgroundColor,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle castFullDescriptionStyle = TextStyle(
    color: AppColors.appBackgroundColor,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle finalSeasonStyle = TextStyle(
    color: AppColors.appErrorColor,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle newsTitleStyle = TextStyle(
    color: AppColors.appBackgroundColor,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
}
