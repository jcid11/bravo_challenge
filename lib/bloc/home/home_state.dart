// import 'package:equatable/equatable.dart';
// import '../../models/product_model.dart';
//
// enum ProductListStatus { initial, loading, success, failure }
//
//
//
// class HomeState extends Equatable {
//   final List<ProductModel>? productList;
//   final ProductListStatus productListStatus;
//
//
//   const HomeState(
//       {this.productList, this.productListStatus = ProductListStatus.initial,
//         });
//
//   HomeState copyWith(
//           {List<ProductModel>? productList,
//           ProductListStatus? productListStatus,
//             }) =>
//       HomeState(
//           productList: productList ?? this.productList,
//           productListStatus: productListStatus ?? this.productListStatus,
//         );
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [productList, productListStatus,
//     ];
// }
