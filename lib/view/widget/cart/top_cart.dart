import 'package:flutter/material.dart';

import '../../../core/constant/app_color.dart';

class TopCart extends StatelessWidget {
  const TopCart({
    super.key,
    required this.text,
  });

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          color: AppColor.secondaryColor,
          borderRadius: BorderRadius.circular(20)),
      child: Text(
        text,
        style: const TextStyle(color: Colors.black, fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }
}
