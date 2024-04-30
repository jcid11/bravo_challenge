import 'dart:convert';

import 'package:flutter/material.dart';

class Response {
  Future getAllProduct(BuildContext context) async {
    Map<String, dynamic> jsonAnswer = {};
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/response/response.json");
    await Future.delayed(const Duration(milliseconds: 300), () async {});
    final jsonResult = jsonDecode(data);
    jsonAnswer = {'success': true, 'data': jsonResult};
    return jsonAnswer;
  }

  Future getProduct(BuildContext context, int itemId) async {
    Map<String, dynamic> jsonAnswer = {};
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/response/response.json");
    await Future.delayed(const Duration(milliseconds: 300), () async {});

    final jsonResult = jsonDecode(data);
    for (var element in jsonResult['data']['list']) {
      if (element['idArticulo'] == itemId) {
        jsonAnswer = element;
        break;
      }
    }
    return jsonAnswer.isEmpty
        ? {"success": false, "data": '', "message": ''}
        : {"success": true, "data": jsonAnswer, "message": ''};
  }
}
