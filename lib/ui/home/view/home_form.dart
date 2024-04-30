import 'package:bravo_challenge/bloc/product/product_cubit.dart';
import 'package:bravo_challenge/ui/product/product_page.dart';
import 'package:bravo_challenge/utils/extensions.dart';
import 'package:bravo_challenge/utils/reusable_widget/circle_button.dart';
import 'package:bravo_challenge/utils/reusable_widget/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../bloc/cart/cart_bloc.dart';
import '../../../bloc/cart/cart_event.dart';
import '../../../bloc/cart/cart_state.dart';
import '../../../bloc/home/home_bloc.dart';
import '../../../bloc/home/home_state.dart';
import '../../../models/card_model.dart';
import '../../../models/product_model.dart';
import '../../../utils/theme.dart';
import '../../cart/cart_page.dart';

class ProductListContainer extends StatelessWidget {
  const ProductListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, state) {
        if (state.productListStatus == ProductListStatus.success) {
          return LayoutBuilder(
              builder: (context, constraints) => SizedBox(
                    height: constraints.maxHeight,
                    child: ListView.separated(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemBuilder: (BuildContext context, int index) {
                        final product = state.productList![index];
                        return Card(
                          elevation: 4,
                          color: ThemeApp.primaryColor,
                          child: RawMaterialButton(
                            onPressed: () => Navigator.push<void>(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                          create: (_) => ProductCubit(
                                              context: context,
                                              productId: product.id),
                                          child: const ProductPage(),
                                        ))),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.only(left: 20, right: 16),
                              trailing: rowFunctionality(context, product),
                              title: Text(
                                product.name,
                                style: context.listTextStyle,
                              ),
                              subtitle: Text(
                                '\$${product.price.toString()}0',
                                style: context.listTextStyle!.copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 10,
                      ),
                      itemCount: state.productList!.length,
                    ),
                  ));
        }
        if (state.productListStatus == ProductListStatus.failure) {
          return const Text(' a mistake has happen');
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

Widget rowFunctionality(BuildContext context, ProductModel product) {
  int assignedAddingValue = 0;
  int assignedRemovingValue = 0;
  return SizedBox(
    width: 90,
    child: BlocBuilder<CartBloc, CartState>(
      builder: (BuildContext context, state) {
        CartItem? cartItem;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Builder(builder: (context) {
                  if (state.removeLoadingStatus ==
                      RemoveLoadingStatus.loading) {
                    cartItem = state.cartItems?.singleWhere(
                        (element) =>
                            element!.product.id == assignedRemovingValue,
                        orElse: () => null);
                    assignedRemovingValue = 0;
                    if (cartItem != null && cartItem!.quantity > 0) {
                      return loadingAnimation();
                    }
                  }
                  return BuildCircleIconButton(
                      onPressed: () {
                        assignedRemovingValue = product.id;
                        context.read<CartBloc>().add(RemoveQuantityEvent(
                            product));
                      },
                      icon: Icons.remove,
                      iconColor: Colors.teal,
                      circleColor: ThemeApp.secondaryColor);
                }),
                const SizedBox(
                  width: 4,
                ),
                SizedBox(
                  width: 26,
                  child: Builder(
                    builder: (context) {
                      if (state.cartItems != null &&
                          state.cartItems!.isNotEmpty) {
                        for (var element in state.cartItems!) {
                          if (element!.product.name == product.name) {
                            cartItem = element;
                            break;
                          }
                        }
                        if (cartItem != null) {
                          return BuildText(
                            textAlign: TextAlign.center,
                            text: '${cartItem!.quantity}',
                            color: ThemeApp.secondaryColor,
                            fontSize: 17,
                          );
                        }
                      }
                      return const BuildText(
                        textAlign: TextAlign.center,
                        text: '0',
                        color: ThemeApp.secondaryColor,
                        fontSize: 17,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Builder(builder: (BuildContext context) {
                  if (state.addLoadingStatus == AddLoadingStatus.loading) {
                    if (assignedAddingValue == product.id) {
                      assignedAddingValue = 0;
                      return loadingAnimation();
                    }
                  }
                  return BuildCircleIconButton(
                    onPressed: () {
                      assignedAddingValue = product.id;
                      context.read<CartBloc>().add(AddQuantityEvent(product));
                    },
                    icon: Icons.add,
                    iconColor: Colors.teal,
                    circleColor: ThemeApp.secondaryColor,
                  );
                })
              ],
            ),
          ],
        );
      },
    ),
  );
}

Widget amountQuantityContainer() => BlocBuilder<CartBloc, CartState>(
      builder: (BuildContext context, state) {
        return Visibility(
          visible: state.itemQuantity != 0 ? true : false,
          child: Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: ThemeApp.generalBorderRadius),
              child: Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BuildText(
                        text: '${state.itemQuantity} producto',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      BuildText(
                        text: '\$${state.totalAmount}',
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: ThemeApp.generalBorderRadius),
                    child: RawMaterialButton(
                      onPressed: () {},
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
                        child: BuildText(
                          text: 'Ver',
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );

Widget cartIconContainer(BuildContext context) => Stack(
      children: [
        RawMaterialButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CartPage()));
            },
            child: const Icon(
              Icons.shopping_cart,
              size: 28,
            )),
        BlocBuilder<CartBloc, CartState>(
          builder: (BuildContext context, state) {
            return Visibility(
              visible: state.itemQuantity != 0 ? true : false,
              child: Positioned(
                  top: 6,
                  right: 0,
                  left: 18,
                  child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 15.2,
                        width: 15.2,
                        decoration: const BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                        child: Center(
                            child: BuildText(
                          text: state.itemQuantity.toString(),
                          color: Colors.white,
                          fontSize: 8.5,
                          fontWeight: FontWeight.bold,
                        )),
                      ))),
            );
          },
        )
      ],
    );

Widget loadingAnimation() => Container(
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Lottie.asset('assets/lottie/icon-loading.json',
            width: 16, height: 16),
      ),
    );
