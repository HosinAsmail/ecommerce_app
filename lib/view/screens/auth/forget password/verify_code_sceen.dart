import 'package:test/core/constant/app_color.dart';
import 'package:test/core/constant/routes.dart';
import 'package:test/core/functions/my_snack_bar.dart';
import '../../../../core/functions/alert_loading.dart';
import '../../../../core/functions/close_loading_dialog.dart';
import '../../../../cubits/auth cubit/auth_cubit.dart';
import 'package:test/view/widget/auth/custom_text_body_auth.dart';
import 'package:test/view/widget/auth/custom_text_title_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

class VerifyCodeScreen extends StatelessWidget {
  const VerifyCodeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final argument = Get.arguments;
    final bool isSignUpScreen = argument['isSignUp'];
    final String email = argument['email'];
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is VerifyCodeFailure) {
          closeLoadingDialog();
          mySnackBar(AppColor.failureColor, "failed", state.errorMessage);
        } else if (state is CheckSendFailure) {
          closeLoadingDialog();
          mySnackBar(AppColor.failureColor, "failed", state.errorMessage);
        } else if (state is VerifyCodeSuccess) {
          if (isSignUpScreen == false) {
            closeLoadingDialog();
            Get.offNamed(AppRoute.resetPasswordScreen,
                arguments: {'email': email});
          } else {
            Get.offAllNamed(AppRoute.successAuthScreen,
                arguments: {'isSignUp': true});
          }
          mySnackBar(AppColor.successColor, 'Success', 'successfully verified');
        } else if (state is VerifyCodeLoading) {
          alertLoading();
        } else if (state is CheckSendSuccess) {
          mySnackBar(AppColor.successColor, 'success',
              'the verification code sent successfully');
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          backgroundColor: AppColor.background,
          elevation: 0.0,
          title: Text(
            'Verification Code',
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: AppColor.grey),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
          child: ListView(
            children: [
              const CustomTextTitleAuth(
                title: 'Check Code',
              ),
              CustomTextBodyAuth(
                bodyText: 'Please Enter The Digits Sent To: $email',
              ),
              const SizedBox(
                height: 15,
              ),
              OtpTextField(
                fieldWidth: 45.0,
                numberOfFields: 5,
                borderColor: AppColor.primaryColor,
                showFieldAsBox: true,
                borderRadius: BorderRadius.circular(10),
                onSubmit: (code) {
                  context
                      .read<AuthCubit>()
                      .verifyCode(code, email, "$isSignUpScreen");
                },
              ),
              const SizedBox(
                height: 35,
              ),
              TextButton(
                  onPressed: () {
                    context.read<AuthCubit>().checkSendEmail(email);
                  },
                  child: const Text(
                    'Resend a new verification code',
                    style: TextStyle(
                      color: AppColor.secondaryColor,
                      fontSize: 20,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
