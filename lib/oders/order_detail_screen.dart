import 'package:flutter/material.dart';
import 'package:new_user_shop_app/home/models/product_model.dart';
import 'package:new_user_shop_app/oders/order_model.dart';
import 'package:new_user_shop_app/widget/product_card.dart';
import 'package:new_user_shop_app/widget/product_detail_card.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key, required this.order});
  final OrderModel order;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
      ),
      body: ListView(
        children: [
          ...widget.order.products.map(
            (e) {
              return ProductCard(
                product: e,
                navigateToDetail: () => navigateToProductDetailScreen(e),
              );
            },
          ).toList(),
        ],
      ),
    );
  }

  void navigateToProductDetailScreen(ProductModel product) {
    final route = MaterialPageRoute(
        builder: (context) => ProductDetailCard(product: product));
    Navigator.push(context, route);
  }
}
