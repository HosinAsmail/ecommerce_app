import 'package:flutter/material.dart';

import '../../../core/constant/app_color.dart';

class CustomTextHome extends StatelessWidget {
  const CustomTextHome({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: const TextStyle(
            color: AppColor.failureColor,
            fontWeight: FontWeight.bold,
            fontSize: 25),
      ),
    );
  }
}
