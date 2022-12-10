import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_user_shop_app/home/models/product_model.dart';
import 'package:new_user_shop_app/oders/bloc/order_bloc.dart';
import 'package:new_user_shop_app/oders/order_detail_screen.dart';
import 'package:new_user_shop_app/widget/product_detail_card.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    fetchOrder();
  }

  @override
  Widget build(BuildContext context) {
    final inrCurrency = NumberFormat.simpleCurrency(locale: 'en_in');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: RefreshIndicator(
        onRefresh: () async => context.read<OrderBloc>().add(OrderFetchEvent()),
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderFetchState) {
              final orders = state.orders;
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Card(
                    elevation: 3.0,
                    margin: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        final route = MaterialPageRoute(
                          builder: (context) => OrderDetailScreen(order: order),
                        );
                        Navigator.push(context, route);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              child: Text('${index + 1}'),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Products: ${order.products.length} Items',
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          'Payable: ${inrCurrency.format(order.payment.amount / 100)}',
                                        ),
                                        const SizedBox(height: 10),
                                        Visibility(
                                          visible: order.address != null,
                                          child: Text(
                                            '${order.address?.shortReadable()}',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Chip(
                                    label: Text(
                                      order.orderStatus,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is OrderLoadingState) {
              return const CircularProgressIndicator();
            }
            return const Center(
              child: Text('No Order'),
            );
          },
        ),
      ),
    );
  }

  void navigateToProductDetail(ProductModel product) {
    final route = MaterialPageRoute(
      builder: (context) => ProductDetailScreen(product: product),
    );
    Navigator.push(context, route);
  }

  void fetchOrder() {
    final bloc = context.read<OrderBloc>();
    final event = OrderFetchEvent();
    bloc.add(event);
  }
}
