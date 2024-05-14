import 'package:bravo_challenge/bloc/login/login_cubit.dart';
import 'package:bravo_challenge/ui/login/view/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../bloc/app/app_bloc.dart';
import '../../../bloc/app/app_state.dart';
import '../../../utils/show_loading_dialog.dart';
import '../../../utils/theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (BuildContext context, state) {
        if (state.status == AppStatus.authenticated) {
          Navigator.of(context, rootNavigator: true).pop();

        }
      },
      child: BlocListener<LoginCubit, LoginState>(
        listener: (BuildContext context, state) {
          if (state.status.isSubmissionFailure) {
            Navigator.of(context, rootNavigator: true).pop();
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Authentication Failure'),
                ),
              );
          } else if (state.status.isSubmissionInProgress) {
            showLoading(context);
          }
        },
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child:  Scaffold(
            body: SafeArea(
              child: ThemeApp.appPadding(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height-kToolbarHeight,
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height*0.44,),
                        const EmailInput(),
                        const PasswordInput(),
                        const LoginButton(),
                        const Spacer(),
                        const GoogleButton(),
                        const SizedBox(height:4,)
                        ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
