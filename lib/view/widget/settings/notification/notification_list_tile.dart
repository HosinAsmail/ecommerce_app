import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:test/core/constant/app_color.dart';
import 'package:test/data/model/notification_model.dart';

class NotificationListTile extends StatelessWidget {
  const NotificationListTile({
    super.key,
    required this.notificationModel,
  });
  final NotificationModel notificationModel;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColor.secondaryColor),
          child: ListTile(
            onTap: () {},
            title: Text(notificationModel.notificationTitle!),
            subtitle: Text(notificationModel.notificationBody!),
          ),
        ),
        Positioned(
            left: 5,
            top: 3,
            child: Text(
              Jiffy.parse(notificationModel.notificationDatetime!).fromNow(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
