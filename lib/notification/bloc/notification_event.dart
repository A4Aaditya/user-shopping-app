part of 'notification_bloc.dart';

abstract class NotificationEvent {}

class SendBookingNotification extends NotificationEvent {
  final OrderModel order;
  SendBookingNotification(this.order);
}

class SenCancelNotification extends NotificationEvent {
  final OrderModel order;
  SenCancelNotification(this.order);
}
