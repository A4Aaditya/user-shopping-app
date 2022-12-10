import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_user_shop_app/profile/address/address_model.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({
    super.key,
    this.address,
    this.isEditMode = false,
    this.docId,
  });
  final AddressModel? address;
  final bool isEditMode;
  final String? docId;

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  @override
  void initState() {
    super.initState();
    numberController.text = widget.address?.phoneNumber ?? '';
    fullNameController.text = widget.address?.name ?? '';
    pinController.text = widget.address?.pincode ?? '';
    houseController.text = widget.address?.house ?? '';
    areaController.text = widget.address?.area ?? '';
    landmarkController.text = widget.address?.landMark ?? '';
    townController.text = widget.address?.town ?? '';
    stateInitial = widget.address?.state ?? stateInitial;
  }

  final fullNameController = TextEditingController();
  final numberController = TextEditingController();
  final pinController = TextEditingController();
  final houseController = TextEditingController();
  final areaController = TextEditingController();
  final landmarkController = TextEditingController();
  final townController = TextEditingController();
  List state = [
    'Bihar',
    'UP',
    'Jharkhand',
    'Maharastra',
    'Madhya Pradesh',
  ];
  String? stateInitial;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Address'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const SizedBox(height: 12),
          // name
          TextFormField(
            controller: fullNameController,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              hintText: 'Full Name',
              filled: true,
              fillColor: Color.fromARGB(255, 225, 225, 225),
            ),
          ),
          const SizedBox(height: 12),
          // number
          TextFormField(
            controller: numberController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Mobile Number',
              filled: true,
              fillColor: Color.fromARGB(255, 225, 225, 225),
            ),
          ),
          const SizedBox(height: 12),
          // pincode
          TextFormField(
            controller: pinController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Pincode',
              filled: true,
              fillColor: Color.fromARGB(255, 225, 225, 225),
            ),
          ),
          const SizedBox(height: 12),
          // flat , house,building
          TextFormField(
            controller: houseController,
            decoration: const InputDecoration(
              hintText: 'Flat,House no, Building, Company,Apartment',
              filled: true,
              fillColor: Color.fromARGB(255, 225, 225, 225),
            ),
          ),
          const SizedBox(height: 12),
          // area, street
          TextFormField(
            controller: areaController,
            decoration: const InputDecoration(
              hintText: 'Area,Street,Setcor,Village',
              filled: true,
              fillColor: Color.fromARGB(255, 225, 225, 225),
            ),
          ),
          const SizedBox(height: 12),
          // landmark
          TextFormField(
            controller: landmarkController,
            decoration: const InputDecoration(
              hintText: 'Landmark',
              filled: true,
              fillColor: Color.fromARGB(255, 225, 225, 225),
            ),
          ),
          const SizedBox(height: 12),
          // town city
          TextFormField(
            controller: townController,
            decoration: const InputDecoration(
              hintText: 'Town/City',
              filled: true,
              fillColor: Color.fromARGB(255, 225, 225, 225),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  value: stateInitial,
                  isExpanded: true,
                  hint: const Text('Select State'),
                  items: state.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  }).toList(),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  onChanged: (value) {
                    setState(() {
                      stateInitial = value.toString();
                    });
                  }),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed:
                widget.isEditMode ? editButtonPressed : saveButtonPressed,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: widget.isEditMode
                  ? const Text('Edit Address')
                  : const Text('Save Address'),
            ),
          )
        ],
      ),
    );
  }

  void saveButtonPressed() async {
    await FirebaseFirestore.instance.collection('address').add(body);
  }

  void editButtonPressed() async {
    final docId = widget.address?.id;
    await FirebaseFirestore.instance
        .collection('address')
        .doc(docId)
        .update(body);
  }

  Map<String, dynamic> get body {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final phone = numberController.text.trim();
    final name = fullNameController.text.trim();
    final pincode = pinController.text.trim();
    final house = houseController.text.trim();
    final area = areaController.text.trim();
    final landMark = landmarkController.text.trim();
    final town = townController.text.trim();
    return {
      'phone_number': phone,
      'full_name': name,
      'pin_code': pincode,
      'house': house,
      'area': area,
      'land_mark': landMark,
      'town': town,
      'state': stateInitial,
      'uid': uid,
    };
  }
}
