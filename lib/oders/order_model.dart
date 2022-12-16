import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_user_shop_app/home/models/product_model.dart';
import 'package:new_user_shop_app/profile/address/address_model.dart';

class OrderModel {
  final String id;
  final String createdBy;
  final String orderStatus;
  final String paymentType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final AddressModel? address;
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
    required this.address,
  });
  factory OrderModel.fromMap(Map<String, dynamic> map, {String? id}) {
    final createdBy = map['updated_at'] as Timestamp;
    final updatedAt = map['created_at'] as Timestamp;
    final addressJson = map['address'];
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
      address: addressJson == null
          ? null
          : AddressModel.fromMap(addressJson, id: null),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_by': createdBy,
      'order_status': orderStatus,
      'payment_type': paymentType,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'address': address?.toMap(),
      'payment': payment.toMap(),
      'products': products.map((x) => x.toMap()).toList(),
    };
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
  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'paymentId': paymentId,
      'orderId': orderId,
      'signature': signature,
    };
  }
}
