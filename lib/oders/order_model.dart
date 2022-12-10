import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_user_shop_app/home/models/product_model.dart';

class OrderModel {
  final String id;
  final String createdBy;
  final String orderStatus;
  final String paymentType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PaymentModel payment;
  final List<ProductModel> products;
  const OrderModel({
    required this.id,
    required this.createdBy,
    required this.orderStatus,
    required this.paymentType,
    required this.createdAt,
    required this.updatedAt,
    required this.payment,
    required this.products,
  });
  factory OrderModel.fromMap(Map<String, dynamic> map, {String? id}) {
    final createdBy = map['updated_at'] as Timestamp;
    final updatedAt = map['created_at'] as Timestamp;
    final mapProduct = map['items'] as List;
    final payment = PaymentModel.fromMap(map['payment']);
    final products = mapProduct.map((e) {
      return ProductModel.fromMap(e);
    }).toList();
    return OrderModel(
      id: id ?? map['id'],
      createdBy: map['created_by'],
      orderStatus: map['order_status'],
      paymentType: map['payment_type'],
      payment: payment,
      createdAt: createdBy.toDate(),
      updatedAt: updatedAt.toDate(),
      products: products,
    );
  }
}

class PaymentModel {
  final int amount;
  final String paymentId;
  final String? orderId;
  final String? signature;
  PaymentModel({
    required this.amount,
    required this.paymentId,
    this.orderId,
    this.signature,
  });

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      amount: map['amount'],
      orderId: map['orderId'],
      paymentId: map['paymentId'],
      signature: map['signature'],
    );
  }
}
