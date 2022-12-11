import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_user_shop_app/profile/address/address_model.dart';
import 'package:new_user_shop_app/profile/address/repository/address_repository.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc({
    required this.repository,
  }) : super(const AddressInitial()) {
    on<InitialAddressEvent>(_initialState);
    on<AddressFetchEvent>(_fetchAddress);
    on<AddressRefreshEvent>(_refreshAddress);
  }

  AddressRepository repository;

  FutureOr<void> _initialState(
    InitialAddressEvent event,
    Emitter<AddressState> emit,
  ) {
    emit(const AddressInitial());
  }

  FutureOr<void> _fetchAddress(
    AddressFetchEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(const AddressLoadingState());

    // API Call
    try {
      final response = await repository.fetchAddress();
      emit(AddressSuccessState(response));
    } catch (e) {
      emit(AddressErrorState(e.toString()));
    }
  }

  FutureOr<void> _refreshAddress(
    AddressRefreshEvent event,
    Emitter<AddressState> emit,
  ) async {
    final currentState = state;
    if (currentState is AddressSuccessState) {
      final data = currentState.data;
      emit(AddressRefreshState(data));
    } else {
      emit(const AddressLoadingState());
    }
    // API Call
    try {
      final response = await repository.fetchAddress();
      emit(AddressSuccessState(response));
    } catch (e) {
      emit(AddressErrorState(e.toString()));
    }
  }
}
