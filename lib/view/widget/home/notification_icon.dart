import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/core/constant/routes.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      width: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: IconButton(
          onPressed: () {
            Get.toNamed(AppRoute.notificationScreen);
          },
          icon: Icon(
            Icons.notifications_active_outlined,
            size: 30,
            color: Colors.grey[600],
          )),
    );
  }
}
