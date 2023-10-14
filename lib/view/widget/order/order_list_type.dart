import 'package:flutter/material.dart';
import 'package:test/core/constant/app_color.dart';

class OrderListType extends StatelessWidget {
  const OrderListType(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.onTap});
  final String title;
  final String subtitle;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.secondaryColor),
      child: ListTile(
        onTap: onTap,
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
