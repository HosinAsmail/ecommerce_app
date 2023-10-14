import 'package:test/core/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void mySnackBar(Color color, String title, String message) {
  Get.snackbar(title, message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: color,
      colorText: AppColor.background);
}
