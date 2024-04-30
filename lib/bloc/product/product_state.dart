import 'package:equatable/equatable.dart';

import '../../models/product_model.dart';

enum ProductStatus { loading, success, failure }

class ProductState extends Equatable {
  final ProductStatus productStatus;
  final ProductModel? product;

  const ProductState(
      {this.productStatus = ProductStatus.loading, this.product});

  ProductState copyWith(
          {ProductModel? product, ProductStatus? productStatus}) =>
      ProductState(
          product: product ?? this.product,
          productStatus: productStatus ?? this.productStatus);

  @override
  // TODO: implement props
  List<Object?> get props => [product, productStatus];
}
