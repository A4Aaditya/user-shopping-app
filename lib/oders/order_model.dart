import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_user_shop_app/home/models/product_model.dart';

class OrderModel {
  final String id;
  final String createdBy;
  final String orderStatus;
  final String paymentType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ProductModel> products;
  OrderModel({
    required this.id,
    required this.createdBy,
    required this.orderStatus,
    required this.paymentType,
    required this.createdAt,
    required this.updatedAt,
    required this.products,
  });
  factory OrderModel.fromMap(Map<String, dynamic> map, {String? id}) {
    final createdBy = map['updated_at'] as Timestamp;
    final updatedAt = map['created_at'] as Timestamp;
    final mapProduct = map['items'] as List;
    final products = mapProduct.map((e) {
      return ProductModel.fromMap(e);
    }).toList();
    return OrderModel(
      id: id ?? map['id'],
      createdBy: map['created_by'],
      orderStatus: map['order_status'],
      paymentType: map['payment_type'],
      createdAt: createdBy.toDate(),
      updatedAt: updatedAt.toDate(),
      products: products,
    );
  }
}
