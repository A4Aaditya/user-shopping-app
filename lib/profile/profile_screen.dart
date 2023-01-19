import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_user_shop_app/authentication/bloc/auth_bloc.dart';
import 'package:new_user_shop_app/constants/routes.dart';
import 'package:new_user_shop_app/oders/order_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: const Text('Order'),
              subtitle: const Text('View your recent and past orders'),
              onTap: navigateToOrderScreen,
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Address'),
              subtitle: const Text('Save your address for fast booking'),
              onTap: navigateToAddressScreeen,
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              subtitle: const Text('Logout me from the app'),
              onTap: logoutPressed,
            ),
          ),
        ],
      ),
    );
  }

  void logoutPressed() {
    final bloc = context.read<AuthBloc>();
    final event = AuthSignoutEvent();
    bloc.add(event);

    Navigator.pushNamedAndRemoveUntil(
      context,
      routeLoginScreen,
      (route) => false,
    );
  }

  void navigateToOrderScreen() {
    Navigator.pushNamed(context, routeOrderScreen);
  }

  void navigateToAddressScreeen() {
    Navigator.pushNamed(context, routeAddressScreen);
  }
}
