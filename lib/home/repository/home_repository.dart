import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_user_shop_app/home/models/product_model.dart';

class HomeRepository {
  final _instance = FirebaseFirestore.instance;
  static const collectionPath = 'product';

  Future<List<ProductModel>> fetchProduct() async {
    try {
      final response = await _instance.collection(collectionPath).get();
      final docs = response.docs;
      final item = docs.map((e) {
        final data = e.data();
        final id = e.id;
        return ProductModel.fromMap(data, id: id);
      }).toList();
      return item;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      rethrow;
    }
  }
}
