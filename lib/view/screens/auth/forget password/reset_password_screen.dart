import 'package:test/core/constant/app_color.dart';
import 'package:test/core/constant/routes.dart';
import 'package:test/core/functions/my_snack_bar.dart';
import 'package:test/core/functions/valid_input_function.dart';
import '../../../../core/functions/close_loading_dialog.dart';
import '../../../../cubits/auth cubit/auth_cubit.dart';
import 'package:test/view/widget/auth/custom_button_auth.dart';
import 'package:test/view/widget/auth/custom_text_body_auth.dart';
import 'package:test/view/widget/auth/custom_text_field_auth.dart';
import 'package:test/view/widget/auth/custom_text_title_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordControl = TextEditingController();
    final TextEditingController confirmPasswordControl =
        TextEditingController();
    final GlobalKey<FormState> fomKey = GlobalKey<FormState>();
    final argument = Get.arguments;
    final String email = argument['email'];

    return Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          backgroundColor: AppColor.background,
          elevation: 0.0,
          title: Text(
            'Reset password',
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: AppColor.grey),
          ),
          centerTitle: true,
        ),
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is ResetPasswordFailure) {
              closeLoadingDialog();
              mySnackBar(AppColor.failureColor, "failed", state.errorMessage);
            } else if (state is ResetPasswordSuccess) {
              closeLoadingDialog();
              Get.offNamed(AppRoute.successAuthScreen,
                  arguments: {'isSignUp': false});
              mySnackBar(AppColor.successColor, 'Success',
                  'successfully changed the password');
            } else if (state is ResetPasswordLoading) {
              Get.defaultDialog(
                  title: '',
                  content: const Center(
                    child: CircularProgressIndicator(),
                  ));
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
            child: Form(
              key: fomKey,
              child: ListView(
                children: [
                  const CustomTextTitleAuth(
                    title: 'New Password',
                  ),
                  const CustomTextBodyAuth(
                    bodyText: 'Please Enter New Password',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFieldAuth(
                      keyboardType: TextInputType.visiblePassword,
                      textDirection: TextDirection.ltr,
                      obscureText: true,
                      onPressedIcon: () {},
                      validator: (value) {
                        return validInput(value!.trim(), 5, 30, 'password');
                      },
                      hintText: 'Enter a new password',
                      label: 'Password',
                      iconData: Icons.lock_outline,
                      controller: passwordControl),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFieldAuth(
                      keyboardType: TextInputType.visiblePassword,
                      textDirection: TextDirection.ltr,
                      obscureText: true,
                      onPressedIcon: () {},
                      validator: (value) {
                        return validInput(value!.trim(), 5, 30, 'password');
                      },
                      hintText: 'Re Enter the new password',
                      label: 'Password',
                      iconData: Icons.lock_outline,
                      controller: confirmPasswordControl),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButtonAuth(
                    text: 'Save',
                    onPressed: () {
                      if (fomKey.currentState!.validate() &&
                          passwordControl.text == confirmPasswordControl.text) {
                        context
                            .read<AuthCubit>()
                            .resetPassword(email, passwordControl.text);
                      } else {
                        mySnackBar(AppColor.failureColor, 'failed',
                            'the passwords are not compatible with each other');
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
