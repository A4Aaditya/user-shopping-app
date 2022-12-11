import 'package:new_user_shop_app/notification/domain/notification_repo.dart';
import 'package:new_user_shop_app/notification/model/notification_model.dart';
import 'package:new_user_shop_app/oders/order_model.dart';

class INotificationRepo implements NotificationRepo {
  @override
  Future<List<NotificationModel>> getNotification() {
    // TODO: implement getNotification
    throw UnimplementedError();
  }

  @override
  Future<NotificationModel> markAsArchieve(String id) {
    // TODO: implement markAsArchieve
    throw UnimplementedError();
  }

  @override
  Future<NotificationModel> markAsRead(String id) {
    // TODO: implement markAsRead
    throw UnimplementedError();
  }

  @override
  Future<NotificationModel> sendNotification(OrderModel body) {
    print(body.id);
    // TODO: implement sendNotification
    throw UnimplementedError();
  }
}
