part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeFailure extends HomeState {
  final String errorMessage;

  const HomeFailure({required this.errorMessage});
}

final class HomeSuccess extends HomeState {}

// products states:
final class ProductsLoading extends HomeState {}

final class ProductsFailure extends HomeState {
  final String errorMessage;

  const ProductsFailure({required this.errorMessage});
}

final class ProductsSuccess extends HomeState {}
