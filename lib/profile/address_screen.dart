import 'package:flutter/material.dart';
import 'package:new_user_shop_app/profile/add_address_screen.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddAddressScreen,
        label: const Text('Add Address'),
      ),
    );
  }

  void navigateToAddAddressScreen() {
    final route =
        MaterialPageRoute(builder: (context) => const AddAddressScreen());
    Navigator.push(context, route);
  }
}
