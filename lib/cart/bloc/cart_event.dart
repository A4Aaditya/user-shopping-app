part of 'cart_bloc.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final ProductModel products;

  AddToCart({required this.products});
}

class RemoveFromCart extends CartEvent {
  final ProductModel products;

  RemoveFromCart({required this.products});
}
