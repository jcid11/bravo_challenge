import 'package:bravo_challenge/service/cart_service.dart';
import 'package:bravo_challenge/utils/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/cart_interface.dart';
import '../../models/card_model.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<CartItem?> _cartItems = [];
  final CartInterface _cartService;
  final String? userEmail;

  CartBloc({required this.userEmail})
      : _cartService = CartService(),
        super(const CartState()) {
    on<AddQuantityEvent>(_addQuantity);
    on<RemoveQuantityEvent>(_removeQuantity);
    on<RemoveFromCartEvent>(_removeItemFromCart);
    on<GetCartEvent>(_getCart);
    on<CleanCartEvent>(_cleanCart);
    on<GetUserEvent>(_assignUserEmail);
    add(GetUserEvent(userEmail: userEmail??''));
    add(GetCartEvent());
  }

  void _assignUserEmail(GetUserEvent event, Emitter<CartState> emit) {
    emit(state.copyWith(userEmail: event.userEmail));
  }

  void _cleanCart(CleanCartEvent event, Emitter<CartState> emit) {
    _cartItems.clear();
    emit(state.copyWith(
        cartItems: [],
        itemQuantity: 0,
        totalAmount: 0,
        totalTaxPrice: 0,
        totalProductPrice: 0));
  }

  void _getCart(GetCartEvent event, Emitter<CartState> emit) async {
    CartItem? item;
    num itemQty = 0;
    num totalProductPrice = 0;
    num totalTaxPrice = 0;
    num totalAmount = 0;
    final result =
        await _cartService.getCartItems(userEmail: state.userEmail ?? '');
    final List<CartItem> cart = result.data;

    if (result.success) {
      for (var element in cart) {
        item = element;
        _cartItems.add(item);

        itemQty += element.quantity;
        totalProductPrice += (element.product.tax == 0
                ? element.product.price
                : (element.product.price * (1 - element.product.tax / 100))) *
            element.quantity;
        totalTaxPrice += (element.product.tax == 0
                ? 0
                : element.product.price * (element.product.tax / 100)) *
            element.quantity;
        totalAmount = totalTaxPrice + totalProductPrice;
      }
    }
    emit(state.copyWith(
        cartItems: _cartItems,
        itemQuantity: int.parse(itemQty.toString()),
        totalProductPrice: totalProductPrice.decimalConversion(),
        totalTaxPrice: totalTaxPrice.decimalConversion(),
        totalAmount: totalAmount.decimalConversion()));
  }

  void _removeItemFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) {
    final existingItem = _cartItems.firstWhere(
      (item) => item?.product == event.product,
      orElse: () => null,
    );
    _cartItems.remove(existingItem);
    emit(state.copyWith(
        cartItems: _cartItems,
        itemQuantity: state.itemQuantity - existingItem!.quantity,
        totalProductPrice:
            state.totalProductPrice - existingItem.product.price));
  }

  void _addQuantity(AddQuantityEvent event, Emitter<CartState> emit) async {
    int quantityAmount = state.itemQuantity;
    double totalProductPrice = state.totalProductPrice;
    double totalTaxAmount = state.totalTaxPrice;
    double totalAmount = state.totalAmount;
    emit(state.copyWith(addLoadingStatus: AddLoadingStatus.loading));
    final existingItem = _cartItems.firstWhere(
      (item) => item?.product.id == event.product.id,
      orElse: () => null,
    );
    final currentItem = existingItem?.product ?? event.product;

    try {
      final result = await _cartService.addToCart(
          productId: event.product.id.toString(),
          userEmail: state.userEmail ?? '',
          name: event.product.name,
          tax: event.product.tax,
          price: event.product.price);
      if (result.success) {
        if (existingItem != null) {
          existingItem.quantity++;
        } else {
          _cartItems.add(CartItem(event.product, 1)); // Add new item to cart
        }
        quantityAmount++;
        (totalProductPrice += currentItem.price * (1 - currentItem.tax / 100));

        totalTaxAmount += currentItem.price * currentItem.tax / 100;
        totalAmount = totalTaxAmount + totalProductPrice;
        emit(state.copyWith(
            cartItems: _cartItems,
            addLoadingStatus: AddLoadingStatus.success,
            itemQuantity: quantityAmount,
            totalTaxPrice: totalTaxAmount.toPrecision(),
            totalAmount: totalAmount.toPrecision(),
            totalProductPrice: totalProductPrice.toPrecision()));
      }
    } catch (_) {
      emit(state.copyWith(addLoadingStatus: AddLoadingStatus.failure));
    }
  }

  void _removeQuantity(
      RemoveQuantityEvent event, Emitter<CartState> emit) async {
    final existingItem = _cartItems.firstWhere(
      (item) => item!.product.id == event.product.id,
      orElse: () => null,
    );

    try {
      if (existingItem != null) {
        emit(state.copyWith(removeLoadingStatus: RemoveLoadingStatus.loading));
        int quantityAmount = state.itemQuantity;
        double totalProductPrice = state.totalProductPrice;
        double totalTaxAmount = state.totalTaxPrice;
        double totalAmount = state.totalAmount;
        final result = await _cartService.removeFromCart(
            productId: event.product.id.toString(),
            userEmail: state.userEmail ?? '');
        if (result.success &&
            state.addLoadingStatus != AddLoadingStatus.loading) {
          /**/
          if (existingItem.quantity > 1) {
            existingItem.quantity--;
          } else {
            _cartItems.remove(existingItem);
          }
          /**/
          quantityAmount--;
          totalProductPrice -= (existingItem.product.price *
              (1 - existingItem.product.tax / 100));
          totalTaxAmount -=
              (existingItem.product.price * existingItem.product.tax / 100);
          totalAmount = totalProductPrice + totalTaxAmount;
          emit(state.copyWith(
              cartItems: _cartItems,
              removeLoadingStatus: RemoveLoadingStatus.success,
              itemQuantity: quantityAmount,
              totalAmount: totalAmount.toPrecision(),
              totalTaxPrice: totalTaxAmount.toPrecision(),
              totalProductPrice: totalProductPrice.toPrecision()));
        }
      }
    } catch (_) {
      emit(state.copyWith(removeLoadingStatus: RemoveLoadingStatus.failure));
    }
  }
}
