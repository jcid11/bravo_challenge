import 'package:bravo_challenge/bloc/cart/cart_bloc.dart';
import 'package:bravo_challenge/bloc/cart/cart_event.dart';
import 'package:bravo_challenge/bloc/home/home_event.dart';
import 'package:bravo_challenge/ui/drawer/drawer.dart';
import 'package:bravo_challenge/ui/home/view/home_form.dart';
import 'package:bravo_challenge/utils/reusable_widget/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/app/app_bloc.dart';
import '../../../bloc/app/app_state.dart';
import '../../../bloc/home/home_bloc.dart';
import '../../../utils/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.microtask(() {
      BlocProvider.of<HomeBloc>(context)
          .add(GetProductsEvent(context: context));
      BlocProvider.of<CartBloc>(context).add(GetUserEvent(
          userEmail: context.read<AppBloc>().state.user.email ?? ''));
      BlocProvider.of<CartBloc>(context).add(GetCartEvent());
    });
    // TODO: implement initState
    super.initState();
  }

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
          // RawMaterialButton(
          //     onPressed: () async {

          //     },
          //
          // child: const Icon(Icons.logout))
          cartIconContainer(context)
        ],
      ),
      body: ThemeApp.appPadding(
        child: Stack(
          children: [
            const SizedBox(height: double.infinity, width: double.infinity),
            const ProductListContainer(),
            amountQuantityContainer()
          ],
        ),
      ),
    );
  }
}
