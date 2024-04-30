import 'package:bravo_challenge/data/cart_interface.dart';
import 'package:bravo_challenge/models/product_model.dart';
import 'package:bravo_challenge/service/response.dart';
import 'package:bravo_challenge/utils/ws_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/card_model.dart';

class CartService implements CartInterface {
  @override
  Future<WsResponse> getProduct(
      {required int productId, required BuildContext context}) async {
    final response = await Response().getProduct(context, productId);
    try {
      if (response['success']) {
        return WsResponse(success: true,data: ProductModel.fromJson(response['data']));
      }
      return WsResponse(success: false);
    } catch (_) {
      return WsResponse(success: false);
    }
  }

  @override
  Future<WsResponse> getCartItems({required String userEmail}) async {
    final QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
        .collection('cartUser')
        .doc(userEmail)
        .collection('cartItems')
        .get();
    List cartList = cartSnapshot.docs.map((doc) {
      return CartItem(
        ProductModel(
            id: int.parse(doc['productId']),
            name: doc['name'],
            price: doc['price'],
            tax: doc['tax']),
        doc['quantity'],
      );
    }).toList();
    try {
      return WsResponse(success: true, data: cartList);
    } catch (_) {
      return WsResponse(success: false);
    }
  }

  @override
  Future<WsResponse> addToCart(
      {required String productId,
      required String userEmail,
      required String name,
      required double tax,
      required double price}) async {
    final cartRef = FirebaseFirestore.instance
        .collection('cartUser')
        .doc(userEmail)
        .collection('cartItems')
        .doc(productId);
    final cartDoc = await cartRef.get();
    try {
      if (cartDoc.exists) {
        await cartRef.update({'quantity': FieldValue.increment(1)});
      } else {
        await cartRef.set({
          'productId': productId,
          'quantity': 1,
          'name': name,
          'price': price,
          'tax': tax
        });
      }
      return WsResponse(success: true);
    } catch (_) {
      return WsResponse(success: false);
    }
  }

  @override
  Future<WsResponse> removeFromCart(
      {required String productId, required String userEmail}) async {
    final cartRef = FirebaseFirestore.instance
        .collection('cartUser')
        .doc(userEmail)
        .collection('cartItems')
        .doc(productId);
    final cartDoc = await cartRef.get();
    try {
      if (cartDoc.exists && cartDoc['quantity'] > 1) {
        await cartRef.update({'quantity': FieldValue.increment(-1)});
      } else {
        await cartRef.delete();
      }
      return WsResponse(success: true);
    } catch (_) {
      return WsResponse(success: false);
    }
  }
}
