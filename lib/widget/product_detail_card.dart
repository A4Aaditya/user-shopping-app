import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_user_shop_app/cart/bloc/cart_bloc.dart';
import 'package:new_user_shop_app/home/bloc/home_bloc.dart';
import 'package:new_user_shop_app/home/models/product_model.dart';

class ProductDetailCard extends StatefulWidget {
  const ProductDetailCard({
    super.key,
    required this.product,
  });
  final ProductModel product;

  @override
  State<ProductDetailCard> createState() => _ProductDetailCardState();
}

class _ProductDetailCardState extends State<ProductDetailCard> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName),
      ),
      body: ListView(
        children: [
          Container(
            height: 300,
            width: double.maxFinite,
            color: Colors.grey,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Text('No Image'));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product : ${product.productName}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Description : ${product.productDescription}',
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Mrp : ₹ ${product.mrp}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Offer-Prices : ₹ ${product.offerPrice}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Visibility(
            visible: !state.products.contains(product),
            replacement: FloatingActionButton.extended(
              onPressed: () {
                final bloc = context.read<CartBloc>();
                final event = RemoveFromCart(products: product);
                bloc.add(event);
              },
              label: const Text('Remove'),
              backgroundColor: Colors.red,
            ),
            child: FloatingActionButton.extended(
              onPressed: () {
                final bloc = context.read<CartBloc>();
                final event = AddToCart(products: product);
                bloc.add(event);
              },
              label: const Text('Add To Cart'),
            ),
          );
        },
      ),
    );
  }
}
