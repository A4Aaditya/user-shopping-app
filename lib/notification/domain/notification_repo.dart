import 'package:new_user_shop_app/notification/model/notification_model.dart';

abstract class NotificationRepo {
  Future<List<NotificationModel>> getNotification();
  Future<NotificationModel> sendNotification(Map<String, dynamic> body);
  Future<NotificationModel> markAsRead(String id);
  Future<NotificationModel> markAsArchieve(String id);
}
