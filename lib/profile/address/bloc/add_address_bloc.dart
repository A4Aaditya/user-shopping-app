import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_user_shop_app/profile/address/repository/address_repository.dart';

part 'add_address_event.dart';
part 'add_address_state.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  AddressRepository repository;
  AddAddressBloc(this.repository) : super(AddAddressInitial()) {
    on<NewAddAddressEvent>(_addAddress);
    on<UpdateAddressEvent>(_updateAddress);
  }

  FutureOr<void> _addAddress(
    NewAddAddressEvent event,
    Emitter<AddAddressState> emit,
  ) async {
    emit(AddAddressLoadingState());
    try {
      final response = await repository.addAddress(event.body);
      if (response == true) {
        emit(AddAddressSuccessState());
      } else {
        emit(AddAddressErrorState(
            errorMessage: 'Unable to add address please try again'));
      }
    } catch (e) {
      emit(AddAddressErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _updateAddress(
    UpdateAddressEvent event,
    Emitter<AddAddressState> emit,
  ) async {
    emit(AddAddressLoadingState());
    try {
      final response = await repository.updateAddress(event.docId, event.body);

      if (response == true) {
        emit(AddAddressSuccessState());
      } else {
        emit(AddAddressErrorState(
            errorMessage: 'Unable to update address please try again'));
      }
    } catch (e) {
      emit(AddAddressErrorState(errorMessage: e.toString()));
    }
  }
}
