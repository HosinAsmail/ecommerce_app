import 'package:test/core/constant/app_color.dart';
import 'package:flutter/material.dart';

class CustomSignTextAuth extends StatelessWidget {
  const CustomSignTextAuth({
    super.key,
    required this.description,
    required this.text,
    required this.onTap,
  });
  final String description;
  final String text;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          description,
          style: const TextStyle(fontSize: 15),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            text,
            style: const TextStyle(
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
        )
      ],
    );
  }
}
