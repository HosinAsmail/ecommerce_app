import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:test/cubits/order%20cubit/order_cubit.dart';

listenFirebase() {
  FirebaseMessaging.onMessage.listen((message) {
    print('===========================');
    print(message.notification!.title);
    print(message.notification!.body);
    Get.snackbar(message.notification!.title.toString(),
        message.notification!.body.toString());
    FlutterRingtonePlayer.playNotification();
    if (Get.currentRoute == "/orderPending") {
      print("===================context=============${Get.context}");
      OrderCubit orderCubit = Get.context!.read<OrderCubit>();
      orderCubit.pendingOrder();
    }
  });
}

notificationPermission() async {
  // NotificationSettings settings =
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}
