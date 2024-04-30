
import 'package:bravo_challenge/models/product_model.dart';

abstract class CartEvent {}

class AddQuantityEvent extends CartEvent {
  final ProductModel product;

  AddQuantityEvent(this.product);
}

class RemoveQuantityEvent extends CartEvent {
  final ProductModel product;


  RemoveQuantityEvent(this.product);
}

class RemoveFromCartEvent extends CartEvent {
  final ProductModel product;

  RemoveFromCartEvent({required this.product});
}

class GetCartEvent extends CartEvent {

  GetCartEvent();
}

class CleanCartEvent extends CartEvent {}

class GetUserEvent extends CartEvent{
  final String userEmail;

  GetUserEvent({required this.userEmail});

}
