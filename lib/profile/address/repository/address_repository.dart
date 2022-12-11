import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_user_shop_app/profile/address/address_model.dart';

class AddressRepository {
  final _instance = FirebaseFirestore.instance;
  static const collectionPath = 'address';
  final userId = FirebaseAuth.instance.currentUser?.uid;

// fetch address
  Future<List<AddressModel>> fetchAddress() async {
    try {
      final response = await _instance
          .collection(collectionPath)
          .where(AddressModelKey.userId, isEqualTo: userId)
          .get();

      final docs = response.docs;
      final items = docs.map((e) {
        final data = e.data();
        final id = e.id;
        return AddressModel.fromMap(data, id: id);
      }).toList();
      return items;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addAddress(Map<String, dynamic> body) async {
    try {
      await _instance.collection(collectionPath).add(body);
      return true;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateAddress(String docId, Map<String, dynamic> body) async {
    try {
      await _instance.collection(collectionPath).doc(docId).update(body);
      return true;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      rethrow;
    }
  }
}
