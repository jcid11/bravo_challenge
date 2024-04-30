import 'package:bravo_challenge/bloc/product/product_state.dart';
import 'package:bravo_challenge/service/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/cart_interface.dart';

class ProductCubit extends Cubit<ProductState> {
  final CartInterface _cartService;
  final BuildContext context;
  final int productId;

  ProductCubit({required this.context, required this.productId})
      : _cartService = CartService(),
        super(const ProductState()) {
    _getProduct(context: context, productId: productId);
  }

  void _getProduct(
      {required BuildContext context, required int productId}) async {
    emit(state.copyWith(productStatus: ProductStatus.loading));
    try {

      final response =
          await _cartService.getProduct(productId: productId, context: context);
      emit(state.copyWith(
          productStatus: ProductStatus.success, product: response.data));
    } catch (_) {
      emit(state.copyWith(productStatus: ProductStatus.failure));
    }
  }
}
