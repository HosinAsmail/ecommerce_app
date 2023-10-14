part of 'favorite_cubit.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

final class FavoriteInitial extends FavoriteState {}

final class AddFavoriteLoading extends FavoriteState {}

final class AddFavoriteSuccess extends FavoriteState {}

final class AddFavoriteFailure extends FavoriteState {
  final String errorMessage;

  const AddFavoriteFailure({required this.errorMessage});
}

//delete favorite:
final class DeleteFavoriteLoading extends FavoriteState {}

final class DeleteFavoriteSuccess extends FavoriteState {}

final class DeleteFavoriteFailure extends FavoriteState {
  final String errorMessage;

  const DeleteFavoriteFailure({required this.errorMessage});
}

//
final class GetFavoriteLoading extends FavoriteState {}

final class GetFavoriteSuccess extends FavoriteState {}

final class GetFavoriteFailure extends FavoriteState {
  final String errorMessage;

  const GetFavoriteFailure({required this.errorMessage});
}
