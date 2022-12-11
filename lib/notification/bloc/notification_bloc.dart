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
  }

  final NotificationRepo repo;

  FutureOr<void> _sendBookingNotification(
    SendBookingNotification event,
    Emitter<NotificationState> emit,
  ) {
    repo.sendNotification(event.order);
  }
}
