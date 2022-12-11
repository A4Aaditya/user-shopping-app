part of 'add_address_bloc.dart';

abstract class AddAddressState {}

class AddAddressInitial extends AddAddressState {}

class AddAddressLoadingState extends AddAddressState {}

class AddAddressErrorState extends AddAddressState {
  AddAddressErrorState({required this.errorMessage});
  final String errorMessage;
}

class AddAddressSuccessState extends AddAddressState {}

class AddAddressUpdateState extends AddAddressState {}
