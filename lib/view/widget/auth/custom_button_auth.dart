import 'package:test/core/constant/app_color.dart';
import 'package:flutter/material.dart';

class CustomButtonAuth extends StatelessWidget {
  const CustomButtonAuth({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(vertical: 20),
            onPressed: onPressed,
            color: AppColor.primaryColor,
            textColor: Colors.white,
            child: Text(
              text,
              style: const TextStyle(fontSize: 15),
            )));
  }
}
