import 'package:bravo_challenge/bloc/login/login_cubit.dart';
import 'package:bravo_challenge/repositories/auth_repository.dart';
import 'package:bravo_challenge/ui/login/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
      child: const LoginScreen(),
    );
  }
}
