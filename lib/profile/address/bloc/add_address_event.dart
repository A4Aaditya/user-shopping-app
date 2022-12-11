part of 'add_address_bloc.dart';

abstract class AddAddressEvent {}

class NewAddAddressEvent extends AddAddressEvent {
  NewAddAddressEvent({required this.body});
  final Map<String, dynamic> body;
}

class UpdateAddressEvent extends AddAddressEvent {
  UpdateAddressEvent({required this.body, required this.docId});
  final String docId;
  final Map<String, dynamic> body;
}
