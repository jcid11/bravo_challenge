import 'package:flutter/cupertino.dart';

import '../utils/ws_response.dart';

abstract class HomeInterface{
  Future<WsResponse> getProducts({required int page,required int pageSize});

}