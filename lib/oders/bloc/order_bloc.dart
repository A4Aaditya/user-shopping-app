import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_user_shop_app/oders/order_model.dart';
import 'package:new_user_shop_app/oders/repository/order_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<InitiatePayment>(_initatePayment);
    on<OpenPaymentPage>(_openPaymentPage);
    on<OrderAddEvent>(_addOrder);
    on<OrderFetchEvent>(_fetchOrder);
  }

  FutureOr<void> _addOrder(
    OrderAddEvent event,
    Emitter<OrderState> emit,
  ) async {
    try {
      emit(OrderLoadingState());
      final response = await OrderRepository().addOrder(event.body);
      if (response != null) {
        emit(OrdeSuccessState(response));
      } else {
        emit(OrderErrorState(message: "Something went wrong"));
      }
    } catch (e) {
      emit(OrderErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _fetchOrder(
    OrderFetchEvent event,
    Emitter<OrderState> emit,
  ) async {
    try {
      final response = await OrderRepository().fetchOrder();

      if (response.isNotEmpty) {
        emit(OrderFetchState(orders: response));
      }
    } catch (e) {
      emit(OrderErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _openPaymentPage(
    OpenPaymentPage event,
    Emitter<OrderState> emit,
  ) {
    emit(PaymentProcessingState());
  }

  FutureOr<void> _initatePayment(
    InitiatePayment event,
    Emitter<OrderState> emit,
  ) {
    emit(OrderInitial());
  }
}
