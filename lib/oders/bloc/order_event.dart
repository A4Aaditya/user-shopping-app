part of 'order_bloc.dart';

abstract class OrderEvent {}

class OrderAddEvent extends OrderEvent {
  final Map<String, dynamic> body;
  OrderAddEvent({required this.body});
}

class InitiatePayment extends OrderEvent {}

class OpenPaymentPage extends OrderEvent {}

class OrderFetchEvent extends OrderEvent {}
