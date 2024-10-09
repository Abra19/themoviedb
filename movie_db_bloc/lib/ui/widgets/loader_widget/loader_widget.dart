import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_db/constants/errors_text.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';
import 'package:the_movie_db/ui/widgets/loader_widget/loader_view_cubit.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  void onCheck(
    BuildContext context,
    LoaderStates state,
  ) {
    final String nextScreen = state == LoaderStates.auth
        ? MainNavigationRouteNames.mainScreen
        : MainNavigationRouteNames.auth;
    if (context.mounted) {
      Navigator.of(context).pushReplacementNamed(nextScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoaderViewCubit, LoaderStates>(
      listenWhen: (_, LoaderStates current) => current != LoaderStates.unknown,
      listener: onCheck,
      bloc: context.read<LoaderViewCubit>(),
      builder: (BuildContext context, LoaderStates state) =>
          state == LoaderStates.error
              ? const Scaffold(
                  body: Center(
                    child: Text(unknownErrorText),
                  ),
                )
              : const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
    );
  }
}
