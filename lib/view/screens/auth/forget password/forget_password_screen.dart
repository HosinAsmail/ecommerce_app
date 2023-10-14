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

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailControl = TextEditingController();
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        elevation: 0.0,
        title: Text(
          'Forget Password',
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: AppColor.grey),
        ),
        centerTitle: true,
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is CheckSendFailure) {
            closeLoadingDialog();
            mySnackBar(AppColor.failureColor, "failed", state.errorMessage);
          } else if (state is CheckSendSuccess) {
            closeLoadingDialog();
            Get.toNamed(AppRoute.verifyCodeScreen,
                arguments: {'isSignUp': false, 'email': emailControl.text});
            mySnackBar(
                AppColor.successColor, 'Success', 'check your email now');
          } else if (state is CheckSendLoading) {
            print("loading form the forget password screen");
            Get.defaultDialog(
                title: '',
                content: const Center(
                  child: CircularProgressIndicator(),
                ));
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
          child: ListView(
            children: [
              const CustomTextTitleAuth(
                title: 'Check Email',
              ),
              const CustomTextBodyAuth(
                bodyText:
                    'Please Enter Your Email Address to Receive a Verification code',
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
              CustomButtonAuth(
                text: 'Check',
                onPressed: () {
                  context.read<AuthCubit>().checkSendEmail(emailControl.text);
                },
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
