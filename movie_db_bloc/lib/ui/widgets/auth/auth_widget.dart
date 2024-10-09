import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';
import 'package:the_movie_db/ui/theme/app_button_style.dart';
import 'package:the_movie_db/ui/theme/app_colors.dart';
import 'package:the_movie_db/ui/theme/app_input_style.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/widgets/auth/auth_view_cubit.dart';

class _AuthDataStorage {
  String login = '';
  String password = '';
}

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  void onLogin(
    BuildContext context,
    AuthCubitState state,
  ) {
    if (context.mounted && state is AuthCubitStateSuccess) {
      MainNavigation.resetNavigation(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthViewCubit, AuthCubitState>(
      listener: onLogin,
      child: Provider<_AuthDataStorage>(
        create: (_) => _AuthDataStorage(),
        child: Scaffold(
          appBar: AppBar.new(
            title: const Text('Login to your account'),
          ),
          body: ListView(
            children: const <Widget>[
              _HeaderWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 25),
          const _FormWidget(),
          const SizedBox(height: 40),
          const Text(
            'In order to use the editing and rating capabilities of TMDb, as well as get personal recommendation you will need to login to your account. If you do not have an account, registering for an account is free and simple.',
            style: AppTextStyle.basicTextStyle,
          ),
          OutlinedButton(
            onPressed: () {},
            style: AppButtonStyle.linkButtonStyle,
            child: const Text(
              'Sign up',
              style: TextStyle(fontSize: AppTextStyle.basicTextSizeStyle),
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            "If you signed up but didn't get a verification email.",
            style: AppTextStyle.basicTextStyle,
          ),
          const SizedBox(height: 5),
          OutlinedButton(
            onPressed: () {},
            style: AppButtonStyle.linkButtonStyle,
            child: const Text(
              'Verify email',
              style: TextStyle(fontSize: AppTextStyle.basicTextSizeStyle),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget();

  @override
  Widget build(BuildContext context) {
    final _AuthDataStorage authStorage = context.read<_AuthDataStorage>();
    final FocusNode nodeOne = FocusNode();
    nodeOne.requestFocus();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Username',
          style: AppTextStyle.formTextStyle,
        ),
        const SizedBox(height: 5),
        TextField(
          decoration: AppInputStyle(
            placeholder: 'Enter username',
            prefixIcon: const Icon(Icons.face),
          ).loginInputDecoration,
          autocorrect: false,
          enableSuggestions: false,
          onChanged: (String value) => authStorage.login = value,
          focusNode: nodeOne,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 30),
        const Text(
          'Password',
          style: AppTextStyle.formTextStyle,
        ),
        const SizedBox(height: 5),
        TextField(
          decoration: AppInputStyle(
            placeholder: 'Enter password',
            prefixIcon: const Icon(Icons.lock),
          ).loginInputDecoration,
          obscureText: true,
          autocorrect: false,
          enableSuggestions: false,
          onChanged: (String value) => authStorage.password = value,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 30),
        const _ErrorMessageWidget(),
        const Row(
          children: <Widget>[
            _AuthButtonWidget(),
            SizedBox(width: 30),
            ResetPasswordButtonWidget(),
          ],
        ),
      ],
    );
  }
}

class ResetPasswordButtonWidget extends StatelessWidget {
  const ResetPasswordButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: AppButtonStyle.linkButtonStyle,
      onPressed: () {},
      child: const Text(
        'Reset password',
        style: TextStyle(fontSize: AppTextStyle.basicTextSizeStyle),
      ),
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget();

  @override
  Widget build(BuildContext context) {
    final _AuthDataStorage authStorage = context.read<_AuthDataStorage>();
    final AuthViewCubit cubit = context.watch<AuthViewCubit>();
    final bool canStartAuth = cubit.state is AuthCubitStateError ||
        cubit.state is AuthCubitStateInitAuth;

    final Future<void> Function()? onPressed = canStartAuth
        ? () => cubit.onLoginPressed(
              login: authStorage.login,
              password: authStorage.password,
            )
        : null;

    final Widget child = cubit.state is AuthCubitStateLoading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              backgroundColor: AppColors.appButtonsColor,
              color: AppColors.appTextColor,
              strokeWidth: 2,
            ),
          )
        : const Text(
            'Login',
            style: AppTextStyle.boldBasicTextStyle,
          );

    return BlocBuilder<AuthViewCubit, AuthCubitState>(
      builder: (BuildContext context, AuthCubitState state) => ElevatedButton(
        style: AppButtonStyle.loginButtonStyle,
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthViewCubit, AuthCubitState>(
      builder: (BuildContext context, AuthCubitState state) {
        return state is AuthCubitStateError
            ? Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  state.errorMessage,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 17,
                  ),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
