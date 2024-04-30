
import 'package:bravo_challenge/models/product_model.dart';

class HomeState{
  final List<ProductModel>? productList;
  final dynamic error;
  final int? nextPageKey;

  HomeState({
    this.productList,
    this.error,
    this.nextPageKey = 1,
  });
}