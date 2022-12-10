part of 'address_bloc.dart';

abstract class AddressState {
  const AddressState();
}

// This state don't have any ui because it will never appear
class AddressInitial extends AddressState {
  const AddressInitial();
}

// Show Cicular progressbar
class AddressLoadingState extends AddressState {
  const AddressLoadingState();
}

// Show data
class AddressSuccessState extends AddressState {
  final List<AddressModel> data;
  const AddressSuccessState(this.data);
}

// Show error screen
class AddressErrorState extends AddressState {
  final String errorMessage;
  const AddressErrorState(this.errorMessage);
}

// Show linear progress bar and old data
class AddressRefreshState extends AddressState {
  final List<AddressModel> data;
  const AddressRefreshState(this.data);
}
