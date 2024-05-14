import 'package:bravo_challenge/ui/drawer/drawer.dart';
import 'package:bravo_challenge/ui/home/view/home_form.dart';
import 'package:bravo_challenge/utils/reusable_widget/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/app/app_bloc.dart';
import '../../../bloc/app/app_state.dart';
import '../../../utils/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerContainer(context),
      appBar: AppBar(
        title: BlocBuilder<AppBloc, AppState>(
          builder: (BuildContext context, state) => BuildText(
            text: 'Bienvenido, ${state.user.email}',
            textOverflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w600,
            color: ThemeApp.primaryColor,
          ),
        ),
        actions: [
          cartIconContainer(context)
        ],
      ),
      body: ThemeApp.appPadding(
        child: Stack(
          children: [
            const SizedBox(height: double.infinity, width: double.infinity),
            const ProductsList(),
            amountQuantityContainer()
          ],
        ),
      ),
    );
  }
}

