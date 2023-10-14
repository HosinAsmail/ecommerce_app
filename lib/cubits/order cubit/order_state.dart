part of 'order_cubit.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

final class PlaceOrderLoading extends OrderState {}
final class PlaceOrderSuccess extends OrderState {}

final class PlaceOrderFailure extends OrderState {
  final String errorMessage;

 const PlaceOrderFailure({required this.errorMessage});
}

final class PendingOrderSuccess extends OrderState {}

final class PendingOrderLoading extends OrderState {}

final class PendingOrderFailure extends OrderState {
  final String errorMessage;

 const PendingOrderFailure({required this.errorMessage});
}

final class ArchiveOrderSuccess extends OrderState {}

final class ArchiveOrderLoading extends OrderState {}

final class ArchiveOrderFailure extends OrderState {
  final String errorMessage;

 const ArchiveOrderFailure({required this.errorMessage});
}

final class OrderDetailsSuccess extends OrderState {}

final class OrderDetailsLoading extends OrderState {}

final class OrderDetailsFailure extends OrderState {
  final String errorMessage;

 const OrderDetailsFailure({required this.errorMessage});
}

final class DeleteOrderSuccess extends OrderState {}

final class DeleteOrderLoading extends OrderState {}

final class DeleteOrderFailure extends OrderState {
  final String errorMessage;

 const DeleteOrderFailure({required this.errorMessage});
}