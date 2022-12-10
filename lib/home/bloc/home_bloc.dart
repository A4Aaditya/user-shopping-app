import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:new_user_shop_app/home/models/product_model.dart';
import 'package:new_user_shop_app/home/repository/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(_initalEvent);
    on<HomeFetchProductEvent>(_fetchProduct);
  }

  FutureOr<void> _fetchProduct(
    HomeFetchProductEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final products = await HomeRepository().fetchProduct();
      emit(HomeFetchProducSuccesstState(products: products));
    } catch (e) {
      emit(HomeFetchProductErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _initalEvent(
    HomeInitialEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(HomeInitial());
  }
}
