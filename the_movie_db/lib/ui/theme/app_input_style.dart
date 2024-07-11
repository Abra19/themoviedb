import 'package:flutter/material.dart';
import 'package:the_movie_db/ui/theme/app_colors.dart';

class AppInputStyle {
  AppInputStyle({
    required this.placeholder,
    required this.prefixIcon,
    this.prefixText,
  }) : loginInputDecoration = InputDecoration(
          isCollapsed: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          labelText: placeholder,
          labelStyle: const TextStyle(
            color: AppColors.appInputHintColor,
            fontStyle: FontStyle.italic,
          ),
          prefixIcon: prefixIcon,
          prefixText: prefixText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.appInputBorderColor,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.appButtonsColor,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.appErrorColor,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.appErrorFocusedColor,
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.appDisabledColor,
            ),
          ),
        );

  String placeholder;
  Icon prefixIcon;
  String? prefixText;
  final InputDecoration loginInputDecoration;
}
