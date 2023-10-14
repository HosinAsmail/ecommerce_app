import 'package:test/core/constant/app_color.dart';
import 'package:test/core/constant/routes.dart';
import 'package:test/view/widget/auth/custom_button_auth.dart';
import 'package:test/view/widget/auth/custom_text_body_auth.dart';
import 'package:test/view/widget/auth/custom_text_title_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessAuthScreen extends StatelessWidget {
  const SuccessAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    bool isSignUp = arguments['isSignUp'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.background,
        elevation: 0.0,
        title: Text(
          'Success',
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: AppColor.grey),
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        const Center(
          child: Icon(
            Icons.check_circle_outline,
            size: 200,
            color: AppColor.primaryColor,
          ),
        ),
        isSignUp
            ? const CustomTextTitleAuth(
                title: 'Congratulations',
              )
            : const CustomTextTitleAuth(
                title: 'Great',
              ),
        isSignUp
            ? const CustomTextBodyAuth(bodyText: 'Successfully registered')
            : const CustomTextBodyAuth(
                bodyText: 'Successfully changed \n the password'),
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(29),
          width: double.infinity,
          child: CustomButtonAuth(
            text: 'Go to Login',
            onPressed: () {
              Get.offAllNamed(AppRoute.loginScreen);
            },
          ),
        ),
        const SizedBox(
          height: 30,
        )
      ]),
    );
  }
}
