part of 'address_cubit.dart';

sealed class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

final class AddressInitial extends AddressState {}

final class GetAddressLoading extends AddressState {}

final class GetAddressSuccess extends AddressState {}

final class GetAddressFailure extends AddressState {
  final String errorMessage;

  const GetAddressFailure({required this.errorMessage});
}

// delete states:
final class DeleteAddressLoading extends AddressState {}

final class DeleteAddressSuccess extends AddressState {}

final class DeleteAddressFailure extends AddressState {
  final String errorMessage;

  const DeleteAddressFailure({required this.errorMessage});
}
final class ChooseAddressLoading extends AddressState {}

final class ChooseAddressSuccess extends AddressState {}
