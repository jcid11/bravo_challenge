import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../bloc/cart/cart_bloc.dart';
import '../../../bloc/cart/cart_event.dart';
import '../../../bloc/cart/cart_state.dart';
import '../../../models/card_model.dart';
import '../../../utils/reusable_widget/circle_button.dart';
import '../../../utils/reusable_widget/text.dart';
import '../../../utils/theme.dart';

Widget cartListTile(BuildContext context, CartItem cartItem,) {
  return Builder(
    builder: (BuildContext context) => Container(
        decoration: BoxDecoration(
          border: Border.all(color: ThemeApp.primaryColor, width: 2),
        ),
        child: ListTile(
            trailing: SizedBox(
              width: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    BuildCircleIconButton(
                      onPressed: () {
                        if (cartItem.quantity == 1) {
                          final slidable = Slidable.of(context);
                          final isClosed = slidable?.actionPaneType.value ==
                              ActionPaneType.none;
                          if (isClosed) {
                            slidable?.openEndActionPane();
                          }
                        } else {
                          context
                              .read<CartBloc>()
                              .add(RemoveQuantityEvent(cartItem.product,));
                        }
                      },
                      icon:
                          cartItem.quantity == 1 ? Icons.delete : Icons.remove,
                      iconColor: ThemeApp.secondaryColor,
                      circleColor: ThemeApp.primaryColor,
                      padding: EdgeInsets.all(cartItem.quantity == 1 ? 4 : 2),
                      iconSize: cartItem.quantity == 1 ? 20 : null,
                    ),
                  const SizedBox(
                    width: 4,
                  ),
                  SizedBox(
                    width: 26,
                    child: BuildText(
                      textAlign: TextAlign.center,
                      text: '${cartItem.quantity}',
                      color: ThemeApp.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  BuildCircleIconButton(
                    onPressed: () {
                      context
                          .read<CartBloc>()
                          .add(AddQuantityEvent(cartItem.product,));
                    },
                    icon: Icons.add,
                    iconColor: ThemeApp.secondaryColor,
                    circleColor: ThemeApp.primaryColor,
                  ),
                ],
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BuildText(
                  text: cartItem.product.name,
                  fontWeight: FontWeight.w700,
                  color: ThemeApp.primaryColor,
                ),
                BuildText(
                  text: '${cartItem.product.price} c/u',
                  fontWeight: FontWeight.w500,
                  color: ThemeApp.primaryColor,
                  fontSize: 12,
                ),
              ],
            ))),
  );
}

Widget totalContainerRow({required String title, required String amount}) =>
    Row(
      children: [
        SizedBox(
            width: 80,
            child: BuildText(
              text: title,
              color: Colors.teal,
              fontSize: 16,
            )),
        Expanded(
            child: Divider(
          color: Colors.grey[300],
        )),
        SizedBox(
            width: 100,
            child: BuildText(
              text: '\$$amount',
              textAlign: TextAlign.end,
              color: Colors.teal,
            )),
      ],
    );

Widget totalResumePayment(BuildContext context) =>
    BlocBuilder<CartBloc, CartState>(
      builder: (BuildContext context, state) => Container(
        margin: const EdgeInsets.only(top: 5),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.20,
        decoration: const BoxDecoration(
            color: ThemeApp.secondaryColor,
            border: Border(
              top: BorderSide(color: ThemeApp.primaryColor, width: 4),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 4,
                spreadRadius: 2,
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Column(
            children: [
              totalContainerRow(
                  title: 'Productos',
                  amount: state.totalProductPrice.toString()),
              const SizedBox(
                height: 10,
              ),
              totalContainerRow(
                  title: 'ITBIS', amount: state.totalTaxPrice.toString()),
              const Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                      width: 60,
                      child: Divider(
                        color: Colors.black,
                        thickness: 2,
                      ))),
              totalContainerRow(
                  title: 'Total', amount: state.totalAmount.toString())
            ],
          ),
        ),
      ),
    );
