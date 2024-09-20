import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/ui/widgets/loader_widget/loader_view_model.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final LoaderViewModel model = context.read<LoaderViewModel>();
    if (model.errorMessage.isNotEmpty) {
      return Scaffold(
        body: Center(
          child: Text(model.errorMessage),
        ),
      );
    }
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
