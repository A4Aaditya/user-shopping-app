import 'package:new_user_shop_app/notification/model/notification_model.dart';
import 'package:new_user_shop_app/oders/order_model.dart';

abstract class NotificationRepo {
  Future<List<NotificationModel>> getNotification();
  Future<NotificationModel> sendNotification(OrderModel order);
  Future<NotificationModel> markAsRead(String id);
  Future<NotificationModel> markAsArchieve(String id);
}
