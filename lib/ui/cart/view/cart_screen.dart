import 'package:bravo_challenge/bloc/cart/cart_event.dart';
import 'package:bravo_challenge/bloc/cart/cart_state.dart';
import 'package:bravo_challenge/models/card_model.dart';
import 'package:bravo_challenge/utils/reusable_widget/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../bloc/cart/cart_bloc.dart';
import '../../../utils/theme.dart';
import 'cart_form.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BuildText(text: 'Cart'),
        centerTitle: true,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (BuildContext context, state) {
          return state.cartItems != null && state.cartItems!.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                        child: SlidableAutoCloseBehavior(
                      closeWhenOpened: true,
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          CartItem cartItem = state.cartItems![index]!;
                          return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Slidable(
                                endActionPane: ActionPane(
                                    extentRatio: 1.23 / 5,
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        flex: 2,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                        backgroundColor: ThemeApp.primaryColor,
                                        foregroundColor:
                                            ThemeApp.secondaryColor,
                                        onPressed: (BuildContext context) {
                                          context.read<CartBloc>().add(
                                              RemoveQuantityEvent(
                                                  cartItem.product));
                                        },
                                      )
                                    ]),
                                child: cartListTile(context, cartItem, ),
                              ));
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          height: 10,
                        ),
                        itemCount: state.cartItems!.length,
                      ),
                    )),
                    totalResumePayment(context)
                  ],
                )
              : const Center(
                  child: BuildText(
                  text: 'No item has been added to the cart.',
                  color: Colors.black,
                ));
        },
      ),
    );
  }
}
