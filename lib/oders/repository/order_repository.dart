import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_user_shop_app/oders/order_model.dart';

class OrderRepository {
  final _instance = FirebaseFirestore.instance;
  static const collectionPath = 'orders';

  Future<OrderModel?> addOrder(Map<String, dynamic> body) async {
    try {
      final ref = await _instance.collection(collectionPath).add(body);
      final doc = await ref.get();
      final data = doc.data();
      if (data == null) {
        return null;
      }
      return OrderModel.fromMap(data, id: doc.id);
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OrderModel>> fetchOrder() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    try {
      final response = await _instance
          .collection(collectionPath)
          .where('created_by', isEqualTo: uid)
          .get();
      final docs = response.docs;
      final item = docs.map((e) {
        final data = e.data();
        final id = e.id;
        return OrderModel.fromMap(data, id: id);
      }).toList();
      return item;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      rethrow;
    }
  }
}
