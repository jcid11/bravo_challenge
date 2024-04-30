import 'dart:convert';

import 'package:bravo_challenge/data/home_interface.dart';
import 'package:bravo_challenge/models/product_model.dart';
import 'package:bravo_challenge/utils/extensions.dart';
import 'package:bravo_challenge/utils/ws_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class HomeService implements HomeInterface {
  // @override
  // Future<WsResponse> getProducts() async {
  //   List<ProductModel> productList = [];
  //   QuerySnapshot querySnapshot =
  //       await FirebaseFirestore.instance.collection('products').get();
  //   final list = querySnapshot.docs;
  //   try {
  //     for (var element in list) {
  //       double tax = element['tax'] != 0 ? element['tax'] / 100 : 0;
  //       var product = ProductModel(
  //           name: element['name'],
  //           description: element['description'],
  //           price: element['price'],
  //           tax: tax,
  //           id: element.id);
  //       productList.add(product);
  //     }
  //     return WsResponse(success: true, data: productList);
  //   } catch (e) {
  //     return WsResponse(success: false, message: e.toString());
  //   }
  // }
  @override
  Future<WsResponse> getProducts({required int page,required int pageSize}) async {
     String url = 'http://10.0.0.195:3001/api/v1/products?limit=$pageSize&page=$page';
    try {
      // final jsonBody = await Response().getAllProduct(context);
      final http.Response response= await http.get(Uri.parse(url));
      final jsonAnswer = jsonDecode(response.body);

      if (jsonAnswer['success']) {
        List jsonList = jsonAnswer['data']['records'];
        List<ProductModel> productList = jsonList
            .map((element) => ProductModel(
                id: element['idArticulo'],
                name: element['nombreArticulo'],
                price: element['associatedPvp'].toString().doubleToInt(),
                tax: element['impuestoArticulo'].toString().doubleToInt()))
            .toList();
        return WsResponse(success: true, data: productList);
      }
      return WsResponse(success: false);
    } catch (e) {
      return WsResponse(success: false, message: e.toString());
    }
  }
}
