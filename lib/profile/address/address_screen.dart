import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_user_shop_app/profile/address/add_address_screen.dart';
import 'package:new_user_shop_app/profile/address/address_model.dart';
import 'package:new_user_shop_app/profile/address/bloc/address_bloc.dart';
import 'package:new_user_shop_app/profile/widget/address_card.dart';

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
      body: BlocBuilder<AddressBloc, AddressState>(
        builder: (context, state) {
          if (state is AddressSuccessState) {
            final addressess = state.data;
            return RefreshIndicator(
              onRefresh: pullRefresh,
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: addressess.length,
                itemBuilder: (context, index) {
                  final address = addressess[index];
                  return AddressCard(
                    address: address,
                    onEdit: () => navgateAddressForm(address, true),
                  );
                },
              ),
            );
          } else if (state is AddressRefreshState) {
            final addressess = state.data;
            return Column(
              children: [
                const LinearProgressIndicator(),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: pullRefresh,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: addressess.length,
                      itemBuilder: (context, index) {
                        final address = addressess[index];
                        return AddressCard(
                          address: address,
                          onEdit: () => navgateAddressForm(address, true),
                        );
                      },
                    ),
                  ),
                )
              ],
            );
          } else if (state is AddressLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navgateAddressForm,
        label: const Text('Add Address'),
      ),
    );
  }

  Future<void> pullRefresh() async {
    final bloc = context.read<AddressBloc>();
    bloc.add(AddressRefreshEvent());
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
