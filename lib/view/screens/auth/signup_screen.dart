import 'package:test/core/constant/app_color.dart';
import 'package:test/core/constant/routes.dart';
import 'package:test/core/functions/my_snack_bar.dart';
import 'package:test/core/functions/valid_input_function.dart';
import '../../../../cubits/auth cubit/auth_cubit.dart';
import 'package:test/view/widget/auth/custom_button_auth.dart';
import 'package:test/view/widget/auth/custom_sign_tex_auth.dart';
import 'package:test/view/widget/auth/custom_text_body_auth.dart';
import 'package:test/view/widget/auth/custom_text_field_auth.dart';
import 'package:test/view/widget/auth/custom_text_title_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../core/functions/close_loading_dialog.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameControl = TextEditingController();
    final TextEditingController phoneControl = TextEditingController();
    final TextEditingController emailControl = TextEditingController();
    final TextEditingController passwordControl = TextEditingController();

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        elevation: 0.0,
        title: Text(
          'Sign up',
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: AppColor.grey),
        ),
        centerTitle: true,
      ),
      body: Builder(builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
          child: Form(
            key: formKey,
            child: BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is SignUpFailure) {
                  closeLoadingDialog();
                  mySnackBar(
                      AppColor.failureColor, "failed", state.errorMessage);
                } else if (state is SignUpSuccess) {
                  closeLoadingDialog();
                  Get.offNamed(AppRoute.verifyCodeScreen, arguments: {
                    'isSignUp': true,
                    "email": emailControl.text
                  });
                  mySnackBar(AppColor.successColor, 'Success',
                      'verify your email now');
                } else if (state is SignUpLoading) {
                  Get.defaultDialog(
                      title: '',
                      content: const Center(
                        child: CircularProgressIndicator(),
                      ));
                }
              },
              child: ListView(
                children: [
                  const CustomTextTitleAuth(
                    title: 'Welcome Here',
                  ),
                  const CustomTextBodyAuth(
                    bodyText:
                        'Sign up with your email and password OR continue with social media',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFieldAuth(
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      return validInput(value!.trim(), 2, 20, 'username');
                    },
                    hintText: 'Enter Your Username',
                    label: 'Username',
                    iconData: Icons.person_outline,
                    controller: usernameControl,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFieldAuth(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      return validInput(value!.trim(), 5, 15, 'phone');
                    },
                    hintText: 'Enter Your phone number',
                    label: 'Phone',
                    iconData: Icons.phone,
                    controller: phoneControl,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFieldAuth(
                    keyboardType: TextInputType.emailAddress,
                    textDirection: TextDirection.ltr,
                    validator: (value) {
                      return validInput(value!.trim(), 7, 100, 'email');
                    },
                    hintText: 'Enter You Email',
                    label: 'Email',
                    iconData: Icons.email_outlined,
                    controller: emailControl,
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
                      return validInput(value!.trim(), 5, 100, 'password');
                    },
                    hintText: 'Enter you password',
                    label: 'Password',
                    iconData: Icons.lock_outline,
                    controller: passwordControl,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButtonAuth(
                    text: 'sign up',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthCubit>().signUpUser(
                            usernameControl.text,
                            passwordControl.text,
                            emailControl.text,
                            phoneControl.text);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomSignTextAuth(
                    text: 'Sign in',
                    description: "Already have an account?  ",
                    onTap: () {
                      Get.offNamed(AppRoute.loginScreen);
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
