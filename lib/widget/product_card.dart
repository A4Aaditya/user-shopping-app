import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_user_shop_app/home/models/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.navigateToDetail,
    this.width = 140,
    this.height = 140,
  });
  final double height;
  final double width;
  final ProductModel product;
  final void Function()? navigateToDetail;

  @override
  Widget build(BuildContext context) {
    final inrCurrency = NumberFormat.simpleCurrency(locale: 'en_in');
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: navigateToDetail,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey,
              ),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Text('No Image'),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.productName,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(product.productDescription),
                    Row(
                      children: [
                        Text(
                          inrCurrency.format(product.mrp),
                          style:
                              Theme.of(context).textTheme.subtitle2?.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w300,
                                  ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          inrCurrency.format(product.offerPrice),
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
