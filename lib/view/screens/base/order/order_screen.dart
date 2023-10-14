import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/core/constant/routes.dart';
import 'package:test/view/widget/home/custom_text_home.dart';
import 'package:test/view/widget/order/order_list_type.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الطلبات")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const CustomTextHome(text: " نوعا الطلبات"),
            OrderListType(
              onTap: () {
                Get.toNamed(AppRoute.orderPendingScreen);
              },
              title: "في الانتظار ",
              subtitle: "الطلبات التي لم يتم إستلامها بعد \nاضفط لرؤية الطلبات",
            ),
            OrderListType(
              onTap: () {
                Get.toNamed(AppRoute.orderArchiveScreen);
              },
              title: "الأرشيف ",
              subtitle: "الطلبات التي تم إيصالها  \nاضفط لرؤية الطلبات",
            ),
          ],
        ),
      ),
    );
  }
}
