import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:test/core/constant/routes.dart';
import 'package:test/core/services/storage%20services/store_all_data.dart';
import 'package:test/core/services/storage%20services/store_step_service.dart';
import 'package:get/get.dart';
import 'package:test/data/model/user%20model/user_model.dart';

void logout() {
  StoreStepService().setStep('1');
  StoreAllData().deleteData('users');
  UserModel userModel = UserModel.instance;
  FirebaseMessaging.instance.unsubscribeFromTopic("users");
  FirebaseMessaging.instance.unsubscribeFromTopic(userModel.userId);
  Get.offAllNamed(AppRoute.loginScreen);
}
