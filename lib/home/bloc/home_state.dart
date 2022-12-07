part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeFetchProductErrorState extends HomeState {
  final String message;
  HomeFetchProductErrorState({required this.message});
}

class HomeFetchProducSuccesstState extends HomeState {
  final List<ProductModel> products;

  HomeFetchProducSuccesstState({required this.products});
}
