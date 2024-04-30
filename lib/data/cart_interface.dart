import 'package:flutter/material.dart';

import '../utils/ws_response.dart';

abstract class CartInterface {
  Future<WsResponse> getCartItems({required String userEmail});

  Future<WsResponse> addToCart({
    required String productId,
    required String userEmail,
    required String name,
    required double tax,
    required double price
  });

  Future<WsResponse> removeFromCart(
      {required String productId, required String userEmail});

  Future<WsResponse> getProduct({required int productId,required BuildContext context});
}
