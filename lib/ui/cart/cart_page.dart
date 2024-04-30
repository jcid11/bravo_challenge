import 'package:bravo_challenge/ui/cart/view/cart_screen.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const CartPage());
  }

  @override
  Widget build(BuildContext context) {
    return const CartScreen();
  }
}
