import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:test/core/constant/app_color.dart';
import 'package:test/core/constant/routes.dart';
import 'package:test/core/functions/alert_exit.dart';
import 'package:test/core/functions/close_loading_dialog.dart';
import 'package:test/core/functions/my_snack_bar.dart';
import 'package:test/core/functions/valid_input_function.dart';
import 'package:test/data/model/user%20model/user_model.dart';
import '../../../../cubits/auth cubit/auth_cubit.dart';
import 'package:test/view/widget/auth/app_logo.dart';
import 'package:test/view/widget/auth/custom_button_auth.dart';
import 'package:test/view/widget/auth/custom_sign_tex_auth.dart';
import 'package:test/view/widget/auth/custom_text_body_auth.dart';
import 'package:test/view/widget/auth/custom_text_field_auth.dart';
import 'package:test/view/widget/auth/custom_text_title_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../core/functions/alert_loading.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    late UserModel userModel;
    final GlobalKey<FormState> fomKey = GlobalKey<FormState>();
    final TextEditingController emailControl = TextEditingController();
    final TextEditingController passwordControl = TextEditingController();

    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          backgroundColor: AppColor.background,
          elevation: 0.0,
          title: Text(
            'Sign in',
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: AppColor.grey),
          ),
          centerTitle: true,
        ),
        body: WillPopScope(
          onWillPop: alertExit,
          child: Builder(builder: (context) {
            return BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is LoginFailure) {
                    closeLoadingDialog();
                    mySnackBar(
                        AppColor.failureColor, "failed", state.errorMessage);
                  } else if (state is LoginSuccess) {
                    userModel = UserModel.instance;
                    closeLoadingDialog();
                    if (userModel.usersApprove == '1') {
                      Get.offAllNamed(AppRoute.baseScreen,
                          arguments: {'initialIndex': 2});
                      FirebaseMessaging.instance.subscribeToTopic("users");
                      FirebaseMessaging.instance
                          .subscribeToTopic(userModel.userId);
                      mySnackBar(AppColor.successColor, 'Success',
                          'successfully logged in');
                    } else {
                      Get.toNamed(AppRoute.verifyCodeScreen, arguments: {
                        'isSignUp': true,
                        "email": emailControl.text
                      });
                      mySnackBar(AppColor.successColor, 'Great job',
                          'verify you email now');
                    }
                  } else if (state is LoginLoading) {
                    alertLoading();
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                  child: Form(
                    key: fomKey,
                    child: ListView(
                      children: [
                        const AppLogo(),
                        const CustomTextTitleAuth(
                          title: 'Welcome Back',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const CustomTextBodyAuth(
                          bodyText:
                              'Sign in with your email and password OR continue with social media',
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextFieldAuth(
                          textDirection: TextDirection.ltr,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            return validInput(value!.trim(), 7, 100, 'email');
                          },
                          hintText: 'Enter you email',
                          label: 'Email',
                          iconData: Icons.email_outlined,
                          controller: emailControl,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextFieldAuth(
                          obscureText: true,
                          onPressedIcon: () {},
                          keyboardType: TextInputType.visiblePassword,
                          textDirection: TextDirection.ltr,
                          validator: (value) {
                            return validInput(value!.trim(), 5, 30, 'password');
                          },
                          hintText: 'Enter you password',
                          label: 'Password',
                          iconData: Icons.lock_outline,
                          controller: passwordControl,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoute.forgetPasswordScreen);
                          },
                          child: Text(
                            'Forget password',
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        CustomButtonAuth(
                          text: 'sign in',
                          onPressed: () {
                            if (fomKey.currentState!.validate()) {
                              context.read<AuthCubit>().login(
                                  emailControl.text, passwordControl.text);
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomSignTextAuth(
                          text: 'Sign up',
                          description: "Don't have an account?  ",
                          onTap: () {
                            Get.toNamed(AppRoute.signUpScreen);
                          },
                        )
                      ],
                    ),
                  ),
                ));
          }),
        ),
      ),
    );
  }
}
