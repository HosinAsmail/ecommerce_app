part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}
//add states:
final class AddCartLoading extends CartState {}

final class AddCartSuccess extends CartState {}

final class AddCartFailure extends CartState {
  final String errorMessage;

  const AddCartFailure({required this.errorMessage});
}

//delete cart:
final class DeleteCartLoading extends CartState {}

final class DeleteCartSuccess extends CartState {}

final class DeleteCartFailure extends CartState {
  final String errorMessage;

  const DeleteCartFailure({required this.errorMessage});
}

//
final class GetCartLoading extends CartState {}

final class GetCartSuccess extends CartState {}

final class GetCartFailure extends CartState {
  final String errorMessage;

  const GetCartFailure({required this.errorMessage});
}

final class GetAllProductsPriceLoading extends CartState {}

final class GetAllProductsPriceSuccess extends CartState {}

