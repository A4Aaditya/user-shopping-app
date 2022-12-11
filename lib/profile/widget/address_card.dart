import 'package:flutter/material.dart';
import 'package:new_user_shop_app/profile/address/address_model.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.address,
    this.onEdit,
  });
  final AddressModel address;
  final void Function()? onEdit;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(address.name, style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 12),
            Text('${address.house} ${address.area} ${address.town}',
                style: const TextStyle(fontSize: 18)),
            Text('${address.landMark} ${address.pincode} ${address.state}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(address.phoneNumber,
                    style: Theme.of(context).textTheme.headline6),
                ElevatedButton(
                  onPressed: onEdit,
                  child: const Text('Edit'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
