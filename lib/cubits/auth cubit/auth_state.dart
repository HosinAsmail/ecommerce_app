part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

// login states:
final class LoginLoading extends AuthState {}
final class LoginFailure extends AuthState {
  final String errorMessage;

  const LoginFailure({required this.errorMessage});
}
final class LoginSuccess extends AuthState {}


// sign up states:
final class SignUpLoading extends AuthState {}
final class SignUpFailure extends AuthState {
  final String errorMessage;

  const SignUpFailure({required this.errorMessage});
}
final class SignUpSuccess extends AuthState {}


// verify code  states:
final class VerifyCodeLoading extends AuthState {}
final class VerifyCodeFailure extends AuthState {
  final String errorMessage;

  const VerifyCodeFailure({required this.errorMessage});
}
final class VerifyCodeSuccess extends AuthState {}

// check send  states:
final class CheckSendLoading extends AuthState {}
final class CheckSendFailure extends AuthState {
  final String errorMessage;

  const CheckSendFailure({required this.errorMessage});
}
final class CheckSendSuccess extends AuthState {}

// reset password  states:
final class ResetPasswordLoading extends AuthState {}
final class ResetPasswordFailure extends AuthState {
  final String errorMessage;

  const ResetPasswordFailure({required this.errorMessage});
}
final class ResetPasswordSuccess extends AuthState {}
