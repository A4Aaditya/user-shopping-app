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
    final order = widget.order;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'Shipping Detail',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              order.address?.fullReadable() ?? '',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'Order Items',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          ...widget.order.products.map(
            (e) {
              return ProductCard(
                product: e,
                height: 100,
                width: 120,
                navigateToDetail: () => navigateToProductDetailScreen(e),
              );
            },
          ).toList(),
          const SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'Billing Detail',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Text('Total Payable'),
          const Text('Delivery Charges'),
          const Text('Platform Fee'),
          const Text('SubTotal'),
          const SizedBox(height: 40),
          Visibility(
            visible: order.orderStatus != 'CANCELLED',
            child: ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
              ),
              onPressed: () => {},
              child: const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text('Canel Order'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigateToProductDetailScreen(ProductModel product) {
    final route = MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product));
    Navigator.push(context, route);
  }
}
