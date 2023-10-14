part of 'product_cubit.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {
  final bool isFirstGetData;
  const ProductLoading({required this.isFirstGetData});
}

final class ProductSuccess extends ProductState {}

final class ProductFailure extends ProductState {
  final String errorMessage;

  const ProductFailure({required this.errorMessage});
}
