import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:the_movie_db/library/providers/notify_provider.dart';
import 'package:the_movie_db/ui/theme/app_button_style.dart';
import 'package:the_movie_db/ui/theme/app_input_style.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/widgets/auth/auth_model.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar.new(
        title: const Text('Login to your account'),
      ),
      body: ListView(
        children: const <Widget>[
          _HeaderWidget(),
        ],
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
          _FormWidget(),
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
  _FormWidget();
  final FocusNode nodeOne = FocusNode();

  @override
  Widget build(BuildContext context) {
    final AuthModel? model = NotifyProvider.watch(context);
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
          controller: model?.loginTextController,
          autocorrect: false,
          enableSuggestions: false,
          onTap: model?.onTapLogin,
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
          controller: model?.passwordTextController,
          onTap: model?.onTapPassword,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 30),
        const Text(
          'Phone',
          style: AppTextStyle.formTextStyle,
        ),
        const SizedBox(height: 5),
        TextField(
          decoration: AppInputStyle(
            placeholder: 'Enter phone',
            prefixIcon: const Icon(Icons.phone),
            prefixText: '+7 ',
          ).loginInputDecoration,
          controller: model?.phoneTextController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            MaskedInputFormatter('(###) ###-##-##'),
          ],
        ),
        const SizedBox(height: 30),
        const _ErrorMessageWidget(),
        Row(
          children: <Widget>[
            ElevatedButton(
              style: AppButtonStyle.loginButtonStyle,
              onPressed: () => model?.auth(context),
              child: const Text(
                'Login',
                style: AppTextStyle.boldBasicTextStyle,
              ),
            ),
            const SizedBox(width: 30),
            OutlinedButton(
              style: AppButtonStyle.linkButtonStyle,
              onPressed: () {},
              child: const Text(
                'Reset password',
                style: TextStyle(fontSize: AppTextStyle.basicTextSizeStyle),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget();

  @override
  Widget build(BuildContext context) {
    final String? errorMessage =
        NotifyProvider.read<AuthModel>(context)?.errorMessage;
    if (errorMessage == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        errorMessage,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 17,
        ),
      ),
    );
  }
}
