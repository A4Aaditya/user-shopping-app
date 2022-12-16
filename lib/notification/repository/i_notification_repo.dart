import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_user_shop_app/notification/domain/notification_repo.dart';
import 'package:new_user_shop_app/notification/model/notification_model.dart';

class INotificationRepo implements NotificationRepo {
  final _fb = FirebaseFirestore.instance;
  static const collectionPath = 'notifications';
  final userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Future<List<NotificationModel>> getNotification() async {
    try {
      final response = await _fb
          .collection(collectionPath)
          .where('user_id', isEqualTo: userId)
          .get();
      final docs = response.docs;
      final item = docs.map((e) {
        final data = e.data();
        final id = e.id;
        return NotificationModel.fromMap(data, id: id);
      }).toList();
      return item;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<NotificationModel> markAsArchieve(String id) async {
    final ref = _fb.collection(collectionPath).doc(id);
    await ref.update(
      {'is_archieve': true},
    );
    final doc = await ref.get();
    final data = doc.data();
    if (data != null) {
      return NotificationModel.fromMap(data, id: doc.id);
    }
    throw Exception('Something went wrong');
  }

  @override
  Future<NotificationModel> markAsRead(String id) async {
    final ref = _fb.collection(collectionPath).doc(id);
    await ref.update(
      {'is_read': true},
    );
    final doc = await ref.get();
    final data = doc.data();
    if (data != null) {
      return NotificationModel.fromMap(data, id: doc.id);
    }
    throw Exception('Something went wrong');
  }

  @override
  Future<NotificationModel> sendNotification(
    Map<String, dynamic> body,
  ) async {
    final payload = {
      ...body,
      'user_id': userId,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    };
    final ref = await _fb.collection(collectionPath).add(payload);
    final doc = await ref.get();
    final data = doc.data();
    if (data != null) {
      return NotificationModel.fromMap(data, id: doc.id);
    }
    throw UnimplementedError();
  }
}
