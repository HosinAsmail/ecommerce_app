import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/core/constant/app_color.dart';
import 'package:test/core/functions/close_loading_dialog.dart';
import 'package:test/core/functions/my_snack_bar.dart';
import 'package:test/cubits/order%20cubit/order_cubit.dart';
import 'package:test/data/model/order_model.dart';
import 'package:test/view/widget/order/card_order.dart';

class OrderPendingScreen extends StatelessWidget {
  const OrderPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OrderCubit orderCubit = context.read<OrderCubit>();
    orderCubit.pendingOrder();

    return Scaffold(
        appBar: AppBar(
          title: const Text("قيد الانتظار"),
          actions: [
            IconButton(
                onPressed: () {
                  orderCubit.pendingOrder();
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            orderCubit.pendingOrder();
          },
          child: BlocConsumer<OrderCubit, OrderState>(
            listener: (context, state) {
              if (state is PendingOrderFailure) {
                mySnackBar(Colors.red, 'failure', state.errorMessage);
              } else if (state is DeleteOrderFailure) {
                mySnackBar(Colors.red, 'failure', state.errorMessage);
              } else if (state is DeleteOrderSuccess) {
                closeLoadingDialog();
                mySnackBar(AppColor.successColor, 'نجاح', "تم حذف الطلب بنجاح");
              }
            },
            builder: (context, state) {
              if (state is PendingOrderLoading || state is DeleteOrderLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                List<OrderModel> orders = orderCubit.pendingOrders;
                if (orders.isNotEmpty) {
                  return ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return CardOrder(
                        orderModel: orders[index],
                      );
                    },
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        "لا يوجد طلبات قيد الإنتظار حالياَ\n اذهب و أضف طلباتك",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: AppColor.black),
                      ),
                    ),
                  );
                }
              }
            },
          ),
        ));
  }
}
