 import 'package:flutter/material.dart';
import 'package:get/get.dart';

void alertLoading() {
    Get.defaultDialog(
        title: '',
        content: const Center(
          child: CircularProgressIndicator(),
        ));
  }