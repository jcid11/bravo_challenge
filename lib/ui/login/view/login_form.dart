import 'package:bravo_challenge/utils/extensions.dart';
import 'package:bravo_challenge/utils/reusable_widget/custom_button.dart';
import 'package:bravo_challenge/utils/reusable_widget/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../bloc/login/login_cubit.dart';
import '../../../utils/theme.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) => SizedBox(
        height: 88,
        child: TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          style: context.loginTextStyle,
          cursorColor: ThemeApp.primaryColor,
          obscureText: true,
          decoration: context.textFieldInputDecoration!.copyWith(
              hintText: 'Password',
              errorText: state.password.invalid ? 'invalid password' : null),
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) => SizedBox(
        height: 88,
        child: TextField(
          style: context.loginTextStyle,
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          cursorColor: ThemeApp.primaryColor,
          decoration: context.textFieldInputDecoration!.copyWith(
              errorText: state.email.invalid ? 'invalid email' : null,
              hintText: 'Youremail@example.com'),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) => BuildCustomButton(
        text: 'Login',
        onPressed: state.status.isValidated
            ? () => context.read<LoginCubit>().logInWithCredentials()
            : () {},
        borderRadius: BorderRadius.circular(10),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        fontSize: 18,
        fontColor: ThemeApp.secondaryColor,
        color: ThemeApp.primaryColor,
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: context.read<LoginCubit>().logInWithGoogle,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        constraints: const BoxConstraints(minHeight: 0),
        child: Container(
          width: 165,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ThemeApp.primaryColor)),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
            child: Row(
              children: [
                Image(
                  image: AssetImage('assets/icons/google.png'),
                  filterQuality: FilterQuality.medium,
                  width: 15,
                  height: 15,
                ),
                SizedBox(
                  width: 10,
                ),
                BuildText(
                  text: 'Continue with google',
                  fontSize: 12,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
