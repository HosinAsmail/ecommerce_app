import 'package:flutter/material.dart';

class CustomTextBodyAuth extends StatelessWidget {
  const CustomTextBodyAuth({
    super.key,
    required this.bodyText,
  });
  final String bodyText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Text(
        bodyText,
        textAlign: TextAlign.center,
        style:const TextStyle(fontSize: 15),
      ),
    );
  }
}
