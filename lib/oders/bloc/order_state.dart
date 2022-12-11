part of 'order_bloc.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoadingState extends OrderState {}

class PaymentProcessingState extends OrderState {}

class OrdeSuccessState extends OrderState {
  final OrderModel order;
  OrdeSuccessState(this.order);
}

class OrderErrorState extends OrderState {
  final String message;
  OrderErrorState({required this.message});
}

class OrderFetchState extends OrderState {
  List<OrderModel> orders = [];
  OrderFetchState({required this.orders});
}
