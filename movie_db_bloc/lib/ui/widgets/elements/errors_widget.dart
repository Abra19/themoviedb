import 'package:flutter/material.dart';

class ErrorsWidget extends StatelessWidget {
  const ErrorsWidget({super.key, required this.message});
  final String? message;

  @override
  Widget build(BuildContext context) {
    if (message != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 16),
        child: Column(
          children: <Widget>[
            Text(
              message!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 17,
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
