part of 'address_bloc.dart';

abstract class AddressEvent {}

class InitialAddressEvent extends AddressEvent {}

class AddressFetchEvent extends AddressEvent {}

class AddressRefreshEvent extends AddressEvent {}
