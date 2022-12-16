import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_user_shop_app/notification/domain/notification_repo.dart';
import 'package:new_user_shop_app/oders/order_model.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc({
    required this.repo,
  }) : super(NotificationInitial()) {
    on<SendBookingNotification>(_sendBookingNotification);
    on<SenCancelNotification>(_sendCanelNotification);
  }

  final NotificationRepo repo;

  FutureOr<void> _sendBookingNotification(
    SendBookingNotification event,
    Emitter<NotificationState> emit,
  ) {
    final payload = {
      'type': 'NEW_BOOKING',
      'title': 'Booking Notification',
      'description': 'Booking Description',
      'meta': event.order.toMap(),
    };
    repo.sendNotification(payload);
  }

  FutureOr<void> _sendCanelNotification(
    SenCancelNotification event,
    Emitter<NotificationState> emit,
  ) {
    final payload = {
      'type': 'CANCEL_BOOKING',
      'title': 'Booking Notification',
      'description': 'Booking Description',
      'meta': event.order.toMap(),
    };
    repo.sendNotification(payload);
  }
}
