import 'package:bravo_challenge/bloc/cart/cart_bloc.dart';
import 'package:bravo_challenge/bloc/cart/cart_event.dart';
import 'package:bravo_challenge/utils/reusable_widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/app/app_bloc.dart';
import '../../bloc/app/app_event.dart';
import '../../utils/theme.dart';

Drawer drawerContainer(BuildContext context) => Drawer(
      backgroundColor: ThemeApp.secondaryColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            BuildCustomButton(
              text: 'LogOut',
              onPressed: () {
                BlocProvider.of<AppBloc>(context)
                    .add(const AppLogoutRequested());
                BlocProvider.of<CartBloc>(context).add(CleanCartEvent());
              },
              color: ThemeApp.primaryColor,
              fontColor: ThemeApp.secondaryColor,
              borderRadius: BorderRadius.circular(12),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
