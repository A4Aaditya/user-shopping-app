import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_user_shop_app/home/models/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<AddToCart>(_addToCart);
    on<RemoveFromCart>(_removeFromCart);
  }

  FutureOr<void> _addToCart(AddToCart event, Emitter<CartState> emit) {
    final products = state.products;
    final updatedState = CartState(products: [...products, event.product]);
    emit(updatedState);
  }

  FutureOr<void> _removeFromCart(
    RemoveFromCart event,
    Emitter<CartState> emit,
  ) {
    final product = state.products;
    final updatedProduct =
        product.where((element) => element != event.product).toList();
    final updatedState = CartState(products: updatedProduct);
    emit(updatedState);
  }
}
