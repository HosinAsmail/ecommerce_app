import 'package:test/core/constant/app_color.dart';
import 'package:test/core/constant/app_image_asset.dart';
import 'package:test/core/constant/routes.dart';
import 'package:test/core/functions/logout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(15),
      child: ListView(children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: Get.width / 3,
              color: AppColor.thirdColor,
            ),
            Positioned(
                bottom: -Get.width / 12,
                child: Container(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: Get.width / 10,
                    backgroundImage: const AssetImage(AppImageAsset.logo),
                  ),
                ))
          ],
        ),
        const SizedBox(
          height: 60,
        ),
        Card(
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Get.toNamed(AppRoute.addressScreen);
                },
                title: const Text('Address'),
                trailing: const Icon(Icons.location_on),
              ),
              ListTile(
                onTap: () {
                  Get.toNamed(AppRoute.notificationScreen);
                },
                title: const Text('Notification'),
                trailing: const Icon(Icons.notifications_active),
              ),
              ListTile(
                onTap: () {
                  launchUrl(Uri.parse("tel:+963969013933"));
                },
                title: const Text('Contact us'),
                trailing: const Icon(Icons.phone),
              ),
              ListTile(
                onTap: () {},
                title: const Text('About us'),
                trailing: const Icon(Icons.info),
              ),
              ListTile(
                onTap: () {
                  Get.defaultDialog(
                    title: 'Warning',
                    middleText: 'are you sure you want to logout?',
                    onCancel: () => Get.back(),
                    onConfirm: () => logout(),
                  );
                },
                title: const Text('Logout'),
                trailing: const Icon(Icons.exit_to_app),
              )
            ],
          ),
        )
      ]),
    );
  }
}
