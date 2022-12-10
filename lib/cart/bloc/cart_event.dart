part of 'cart_bloc.dart';

abstract class CartEvent {
  const CartEvent();
}

class AddToCart extends CartEvent {
  final ProductModel product;

  const AddToCart({
    required this.product,
  });
}

class RemoveFromCart extends CartEvent {
  final ProductModel product;

  const RemoveFromCart({
    required this.product,
  });
}
