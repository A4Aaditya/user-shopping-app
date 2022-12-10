import 'package:flutter/material.dart';
import 'package:new_user_shop_app/oders/order_screen.dart';
import 'package:new_user_shop_app/profile/address/address_screen.dart';

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
              onTap: () {
                final route = MaterialPageRoute(
                  builder: (context) => const OrderScreen(),
                );
                Navigator.push(context, route);
              },
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
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  void navigateToAddressScreeen() {
    final route =
        MaterialPageRoute(builder: (context) => const AddressScreen());
    Navigator.push(context, route);
  }
}
