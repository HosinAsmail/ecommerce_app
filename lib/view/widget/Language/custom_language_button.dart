import 'package:test/core/constant/app_color.dart';
import 'package:flutter/material.dart';

class CustomLanguageButton extends StatelessWidget {
  final void Function()? onPressed;
  final String textButton;

  const CustomLanguageButton(
      {super.key, required this.onPressed, required this.textButton});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: 200,
      height: 50,
      color: AppColor.primaryColor,
      child: MaterialButton(
        textColor: Colors.white,
        onPressed: onPressed,
        child: Text(
          textButton,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
