import 'package:flutter/services.dart';

class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String digitsOnly = newValue.text.replaceAll(RegExp(r'[\D]+'), '');
    final List<String> digitsOnlyChars = digitsOnly.split('');

    final int initialSpecialSymbolsCount = newValue.selection
        .textBefore(newValue.text)
        .replaceAll(RegExp(r'[\d]+'), '')
        .length;
    final int cursorPosition =
        newValue.selection.start - initialSpecialSymbolsCount;
    int finalCursorPosition = cursorPosition;

    final String oldText = oldValue.selection.textInside(oldValue.text);

    if (oldText == ' ' || oldText == '+' || oldText == '(' || oldText == ')') {
      digitsOnlyChars.removeAt(cursorPosition - 1);
      finalCursorPosition -= 2;
    }

    final List<String> formattedList = <String>[];

    for (int i = 0; i < digitsOnlyChars.length; i++) {
      if (i == 0) {
        formattedList.add('+');
      } else if (i == 1) {
        formattedList.add(' (');
      } else if (i == 4) {
        formattedList.add(') ');
      } else if (i == 7 || i == 9) {
        formattedList.add('-');
      }

      if ((i == 0 || i == 7 || i == 9) && i < cursorPosition) {
        finalCursorPosition += 1;
      } else if ((i == 1 || i == 4) && i < cursorPosition) {
        finalCursorPosition += 2;
      }

      if (i < 11) {
        formattedList.add(digitsOnlyChars[i]);
      }
    }

    final String formattedString = formattedList.join();
    return TextEditingValue(
      text: formattedString,
      selection: TextSelection.collapsed(offset: finalCursorPosition),
    );
  }
}
