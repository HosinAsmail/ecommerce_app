import 'dart:io';
import 'package:get/get.dart';
import 'package:test/core/functions/alert_dialog.dart';
Future<bool> alertExit() {
  alertDialog(
      context: Get.context,
      title: "exit the app",
      content: 'are you sure you want to exit the app',
      confirmText: "exit",
      onPressed: () {
        exit(0);
      });
  return Future.value(false);
}
