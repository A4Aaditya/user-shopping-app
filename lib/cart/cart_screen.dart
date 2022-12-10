import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_user_shop_app/cart/bloc/cart_bloc.dart';
import 'package:new_user_shop_app/oders/review_order_screen.dart';
import 'package:new_user_shop_app/home/models/product_model.dart';
import 'package:new_user_shop_app/widget/product_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final products = state.products;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Expanded(
                    child: Visibility(
                      visible: products.isNotEmpty,
                      replacement: Center(
                        child: Text(
                          'No Item in Cart',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          final event = RemoveFromCart(
                            product: product,
                          );
                          return Dismissible(
                            key: ObjectKey(product.id),
                            confirmDismiss: (direction) {
                              if (direction == DismissDirection.endToStart) {
                                return Future.value(true);
                              }
                              return Future.value(false);
                            },
                            secondaryBackground: Container(color: Colors.red),
                            background: Container(color: Colors.blue),
                            onDismissed: (direction) {
                              if (direction == DismissDirection.endToStart) {
                                context.read<CartBloc>().add(event);
                              }
                            },
                            child: Stack(
                              children: [
                                ProductCard(product: product),
                                Positioned(
                                  right: 10,
                                  bottom: 10,
                                  child: ElevatedButton(
                                    style: const ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(
                                        Colors.red,
                                      ),
                                    ),
                                    onPressed: () {
                                      context.read<CartBloc>().add(event);
                                    },
                                    child: const Text('Remove'),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: products.isNotEmpty,
                    child: ElevatedButton(
                      onPressed: () => reviewOrder(state.products),
                      child: const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Center(
                          child: Text('Review Order'),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void reviewOrder(List<ProductModel> products) {
    final route = MaterialPageRoute(
      builder: (context) => ReviewOrderScreen(products: products),
    );
    Navigator.push(context, route);
  }
}
