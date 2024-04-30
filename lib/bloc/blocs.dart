import 'package:bravo_challenge/bloc/cart/cart_bloc.dart';
import 'package:bravo_challenge/bloc/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/auth_repository.dart';
import '../ui/home/home_page.dart';
import '../ui/login/login_page.dart';
import 'app/app_bloc.dart';
import 'app/app_state.dart';

class BlocApp extends StatelessWidget {
  const BlocApp(
      {Key? key, required this.child, required this.authenticationRepository})
      : super(key: key);
  final AuthenticationRepository authenticationRepository;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  AppBloc(authenticationRepository: authenticationRepository)),
          // BlocProvider(create: (_) => HomeBloc()),
          BlocProvider(
              create: (_) => CartBloc(
                  userEmail: authenticationRepository.currentUser.email??''))
        ],
        child: child,
      ),
    );
  }
}

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
