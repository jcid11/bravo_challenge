import 'package:equatable/equatable.dart';

import '../../models/card_model.dart';

enum AddLoadingStatus { success, loading, failure, initial }

enum RemoveLoadingStatus { success, loading, failure, initial }

class CartState extends Equatable {
  final List<CartItem?>? cartItems;
  final AddLoadingStatus addLoadingStatus;
  final RemoveLoadingStatus removeLoadingStatus;
  final int itemQuantity;
  final double totalProductPrice;
  final double totalTaxPrice;
  final double totalAmount;
  final String? userEmail;

  const CartState(
      {this.cartItems,
      this.userEmail = '',
      this.itemQuantity = 0,
      this.totalAmount = 0,
      this.totalTaxPrice = 0,
      this.totalProductPrice = 0,
      this.addLoadingStatus = AddLoadingStatus.initial,
      this.removeLoadingStatus = RemoveLoadingStatus.initial});

  CartState copyWith(
          {List<CartItem?>? cartItems,
          String? userEmail,
          int? itemQuantity,
          double? totalTaxPrice,
          double? totalAmount,
          double? totalProductPrice,
          AddLoadingStatus? addLoadingStatus,
          RemoveLoadingStatus? removeLoadingStatus}) =>
      CartState(
          cartItems: cartItems ?? this.cartItems,
          userEmail: userEmail ?? this.userEmail,
          totalTaxPrice: totalTaxPrice ?? this.totalTaxPrice,
          totalAmount: totalAmount ?? this.totalAmount,
          totalProductPrice: totalProductPrice ?? this.totalProductPrice,
          itemQuantity: itemQuantity ?? this.itemQuantity,
          addLoadingStatus: addLoadingStatus ?? this.addLoadingStatus,
          removeLoadingStatus: removeLoadingStatus ?? this.removeLoadingStatus);

  @override
  List<Object?> get props => [
        addLoadingStatus,
        removeLoadingStatus,
        userEmail,
        totalAmount,
        totalTaxPrice,
        cartItems,
        itemQuantity,
        totalProductPrice
      ];
}
