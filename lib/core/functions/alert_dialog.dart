import 'package:test/core/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void alertDialog(
    {required context,
    required String title,
    required String content,
    required String confirmText,
    confirmButtonColor,
    required void Function() onPressed}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Container(
              constraints: const BoxConstraints(maxWidth: double.minPositive),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )),
          content: Text(
            content,
            style: const TextStyle(fontSize: 20),
          ),
          actions: [
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'إلغاء',
              ),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: onPressed,
              color: confirmButtonColor,
              child: Text(
                confirmText,
              ),
            ),
          ],
        );
      });
}
