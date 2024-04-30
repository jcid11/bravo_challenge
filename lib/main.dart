import 'package:bravo_challenge/bloc/app/app_bloc.dart';
import 'package:bravo_challenge/bloc/blocs.dart';
import 'package:bravo_challenge/repositories/auth_repository.dart';
import 'package:bravo_challenge/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/app/app_state.dart';
import 'bloc/observer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
  Bloc.observer = const CounterObserver();
  runApp(BlocApp(
      authenticationRepository: authenticationRepository,
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeApp.themeDataPrimary(context),
      home: FlowBuilder<AppStatus>(
          state: context.select((AppBloc bloc) => bloc.state.status),
          onGeneratePages: onGenerateAppViewPages),
    );
  }
}
