import 'package:bravo_challenge/bloc/cart/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/app/app_bloc.dart';
import 'view/home_screen.dart';

class HomePage extends StatelessWidget {

  const HomePage({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_)=>CartBloc(userEmail: BlocProvider.of<AppBloc>(context).state.user.email)),
    ], child: const HomeScreen());
  }
}
