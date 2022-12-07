import 'package:flutter/material.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final fullNameController = TextEditingController();
  final numberController = TextEditingController();
  final pinController = TextEditingController();
  final houseController = TextEditingController();
  final areaController = TextEditingController();
  final landmarkController = TextEditingController();
  final townController = TextEditingController();
  List state = ['Bihar', 'UP', 'Jharkhand', 'Maharastra', 'Madhya Pradesh'];
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
            controller: houseController,
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
          )
        ],
      ),
    );
  }
}
