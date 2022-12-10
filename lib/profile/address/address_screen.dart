import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_user_shop_app/profile/address/add_address_screen.dart';
import 'package:new_user_shop_app/profile/address/address_model.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  void initState() {
    super.initState();
    fetchAddress();
  }

  List<AddressModel> addressess = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
      ),
      body: RefreshIndicator(
        onRefresh: fetchAddress,
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: addressess.length,
          itemBuilder: (context, index) {
            final address = addressess[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(address.name,
                        style: Theme.of(context).textTheme.headline6),
                    const SizedBox(height: 12),
                    Text('${address.house} ${address.area} ${address.town}',
                        style: const TextStyle(fontSize: 18)),
                    Text(
                        '${address.landMark} ${address.pincode} ${address.state}',
                        style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(address.phoneNumber,
                            style: Theme.of(context).textTheme.headline6),
                        ElevatedButton(
                          onPressed: () => navgateAddressForm(
                            address,
                            true,
                          ),
                          child: const Text('Edit'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navgateAddressForm,
        label: const Text('Add Address'),
      ),
    );
  }

  Future<void> fetchAddress() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final response = await FirebaseFirestore.instance
        .collection('address')
        .where(AddressModelKey.userId, isEqualTo: uid)
        .get();

    final docs = response.docs;
    final item = docs.map((e) {
      final data = e.data();
      final id = e.id;
      return AddressModel.fromMap(data, id: id);
    }).toList();
    setState(() {
      addressess = item;
    });
  }

  void navgateAddressForm([AddressModel? address, bool? isEditMode]) {
    final route = MaterialPageRoute(
      builder: (context) => AddAddressScreen(
        address: address,
        isEditMode: isEditMode ?? true,
      ),
    );
    Navigator.push(context, route);
  }
}
