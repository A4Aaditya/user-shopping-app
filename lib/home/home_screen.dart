import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_user_shop_app/authentication/bloc/auth_bloc.dart';
import 'package:new_user_shop_app/cart/bloc/cart_bloc.dart';
import 'package:new_user_shop_app/constants/routes.dart';
import 'package:new_user_shop_app/home/bloc/home_bloc.dart';
import 'package:new_user_shop_app/home/models/product_model.dart';
import 'package:new_user_shop_app/widget/product_card.dart';
import 'package:new_user_shop_app/widget/product_detail_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> products = [];
  @override
  void initState() {
    super.initState();
    // Load Homepage
    final homeBloc = context.read<HomeBloc>();
    homeBloc.add(HomeFetchProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              final len = state.products.length;
              return IconButton(
                onPressed: navigateToCartScreen,
                icon: Badge(
                  showBadge: len != 0,
                  badgeContent: Text(
                    '$len',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  child: const Icon(Icons.shopping_bag),
                ),
              );
            },
          ),
          IconButton(
            onPressed: logoutPressed,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeFetchProductErrorState) {
            final message = state.message;
            showSnackBar(message: message, color: Colors.red);
          }
        },
        builder: (context, state) {
          if (state is HomeFetchProducSuccesstState) {
            final products = state.products;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  product: product,
                  navigateToDetail: () {
                    final route = MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailScreen(product: product),
                    );
                    Navigator.push(context, route);
                  },
                );
              },
            );
          } else if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: Column(
              children: [
                const Text('Something went wrong '),
                TextButton(
                  onPressed: tryAgainPressed,
                  child: const Text('Try Again'),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void logoutPressed() {
    final bloc = context.read<AuthBloc>();
    final event = AuthSignoutEvent();
    bloc.add(event);

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoute.routeLoginScreen,
      (route) => false,
    );
  }

  void showSnackBar({required String message, required Color color}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void navigateToCartScreen() {
    Navigator.pushNamed(context, AppRoute.routeCartScreen);
  }

  void tryAgainPressed() {
    final bloc = context.read<HomeBloc>();
    final event = HomeFetchProductEvent();
    bloc.add(event);
  }
}
