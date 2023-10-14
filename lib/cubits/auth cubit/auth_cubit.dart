import 'package:bloc/bloc.dart';
import 'package:test/core/api/crud.dart';
import 'package:test/core/functions/handling_failure_response.dart';
import 'package:test/core/services/storage%20services/store_all_data.dart';
import 'package:test/core/services/storage%20services/store_step_service.dart';
import 'package:test/data/data%20source/remote/auth/login_remote.dart';
import 'package:test/data/data%20source/remote/auth/signup_remote.dart';
import 'package:test/data/data%20source/remote/auth/verify_code_remote.dart';
import 'package:test/data/data%20source/remote/forget%20password/check_send_email_remote.dart';
import 'package:test/data/data%20source/remote/forget%20password/reset_password_remote.dart';
import 'package:test/data/model/user%20model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Crud crud = Crud();
  UserModel? userModel;
  StoreAllData storeAllData = StoreAllData();
  void signUpUser(
      String username, String password, String email, String phone) async {
    emit(SignUpLoading());
    try {
      SignUpRemote signUpRemote = SignUpRemote(crud);
      var response =
          await signUpRemote.postData(username, password, email, phone);
      String? authFailureMessage = handlingFailureMessage(response,
          "the email or the phone is already in use please use another one");
      if (authFailureMessage != null) {
        emit(SignUpFailure(errorMessage: authFailureMessage));
      } else {
        emit(SignUpSuccess());
      }
    } catch (e) {
      if (e is ClientException) {
        emit(const SignUpFailure(
            errorMessage: "the internet is slow, try again"));
      }
      emit(SignUpFailure(errorMessage: "unknown problem : ${e.toString()} "));
    }
  }

  void verifyCode(String code, String email, String isSignUp) async {
    emit(VerifyCodeLoading());
    try {
      VerifyCodeRemote verifyCodeRemote = VerifyCodeRemote(crud);
      var response = await verifyCodeRemote.postData(code, email, isSignUp);

      String? authFailureMessage = handlingFailureMessage(
          response, "the code you provided is not correct");
      if (authFailureMessage != null) {
        emit(VerifyCodeFailure(errorMessage: authFailureMessage));
      } else {
        emit(VerifyCodeSuccess());
      }
    } on Exception catch (e) {
      if (e is ClientException) {
        emit(const VerifyCodeFailure(
            errorMessage: "the internet is slow, try again"));
      }

      emit(VerifyCodeFailure(
          errorMessage: "unknown problem : ${e.toString()} "));
    }
  }

  void login(String email, String password) async {
    emit(LoginLoading());
    try {
      LoginRemote loginData = LoginRemote(crud);
      var response = await loginData.postData(email, password);
      if (response is Map<String, dynamic>) {
        await storeAllData.insertData('users', response['data'][0]);
        await UserModel.init(response['data']);
        userModel = UserModel.instance;
        StoreStepService().setStep("2");
      }
      String? authFailureMessage = handlingFailureMessage(
          response, "the email or the password is not correct");

      if (authFailureMessage != null) {
        emit(LoginFailure(errorMessage: authFailureMessage));
      } else {
        emit(LoginSuccess());
      }
    } on Exception catch (e) {
      if (e is ClientException) {
        emit(const LoginFailure(
            errorMessage: "the internet is slow, try again"));
      }
      emit(LoginFailure(errorMessage: "unknown problem : ${e.toString()} "));
    }
  }

  void checkSendEmail(String email) async {
    emit(CheckSendLoading());
    try {
      CheckSendEmailRemote checkSendEmailRemote = CheckSendEmailRemote(crud);
      var response = await checkSendEmailRemote.postData(email);
      String? authFailureMessage =
          handlingFailureMessage(response, "the email is not existed");
      if (authFailureMessage != null) {
        emit(CheckSendFailure(errorMessage: authFailureMessage));
      } else {
        emit(CheckSendSuccess());
      }
    } on Exception catch (e) {
      if (e is ClientException) {
        emit(const CheckSendFailure(
            errorMessage: "the internet is slow, try again"));
      }
      emit(
          CheckSendFailure(errorMessage: "unknown problem : ${e.toString()} "));
    }
  }

  void resetPassword(String email, String password) async {
    emit(ResetPasswordLoading());
    try {
      ResetPasswordRemote resetPasswordRemote = ResetPasswordRemote(crud);
      var response = await resetPasswordRemote.postData(email, password);
      String? authFailureMessage =
          handlingFailureMessage(response, "the email is not existed");
      if (authFailureMessage != null) {
        emit(ResetPasswordFailure(errorMessage: authFailureMessage));
      } else {
        emit(ResetPasswordSuccess());
      }
    } on Exception catch (e) {
      print("from the reset cubit : $e");
      if (e is ClientException) {
        emit(const ResetPasswordFailure(
            errorMessage: "the internet is slow, try again"));
      }
      emit(ResetPasswordFailure(
          errorMessage: "unknown problem : ${e.toString()} "));
    }
  }
}
