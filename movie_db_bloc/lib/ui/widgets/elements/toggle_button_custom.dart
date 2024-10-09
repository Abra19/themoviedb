import 'package:flutter/material.dart';
import 'package:the_movie_db/ui/theme/app_colors.dart';

class ToggleButtonCustom<T> extends StatelessWidget {
  const ToggleButtonCustom({
    super.key,
    required this.model,
    required this.options,
    required this.isSelected,
    required this.tapFunction,
  });
  final T model;
  final List<String> options;
  final List<bool> isSelected;
  final Future<void> Function(int index) tapFunction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: options.asMap().entries.map((MapEntry<int, String> entry) {
        final int index = entry.key;
        final String text = entry.value;
        final bool selected = isSelected[index];
        final int lastElementIndex = options.length - 1;

        return Expanded(
          child: GestureDetector(
            onTap: () => tapFunction(index),
            child: Container(
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.appBackgroundColor
                    : AppColors.appMovieCardColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(index == 0 ? 15.0 : 0.0),
                  bottomLeft: Radius.circular(index == 0 ? 15.0 : 0.0),
                  topRight: Radius.circular(
                    index == lastElementIndex ? 15.0 : 0.0,
                  ),
                  bottomRight: Radius.circular(
                    index == lastElementIndex ? 15.0 : 0.0,
                  ),
                ),
                border: Border(
                  left: BorderSide(
                    color: AppColors.appBackgroundColor,
                    width: index == 0 ? 1.0 : 0.5,
                  ),
                  top: const BorderSide(color: AppColors.appBackgroundColor),
                  bottom: const BorderSide(color: AppColors.appBackgroundColor),
                  right: BorderSide(
                    color: AppColors.appBackgroundColor,
                    width: index == lastElementIndex ? 1.0 : 0.5,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 8.0,
              ),
              child: Text(
                text,
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: selected
                      ? AppColors.appTextColor
                      : AppColors.appBasicTextColor,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
