import 'package:test/core/constant/routes.dart';
import 'package:test/core/services/storage%20services/store_step_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyMiddleWare extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    String? step=StoreStepService().getStep();
    if (step == '2') {
      return const RouteSettings(
          name: AppRoute.baseScreen, arguments: {'initialIndex': 2});
    } else if (step == '1') {
      return const RouteSettings(name: AppRoute.loginScreen);
    } else {
      return null;
    }
  }
}
