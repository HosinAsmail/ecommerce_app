import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/core/constant/app_color.dart';
import 'package:test/core/functions/my_snack_bar.dart';
import 'package:test/cubits/order%20cubit/order_cubit.dart';
import 'package:test/data/model/order_model.dart';
import 'package:test/view/widget/order/card_order.dart';

class OrderArchiveScreen extends StatelessWidget {
  const OrderArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OrderCubit orderCubit = context.read<OrderCubit>();
    orderCubit.archiveOrder();

    return Scaffold(
        appBar: AppBar(
          title: const Text(" الأرشيف"),
          actions: [
            IconButton(
                onPressed: () {
                  orderCubit.archiveOrder();
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            orderCubit.archiveOrder();
          },
          child: BlocConsumer<OrderCubit, OrderState>(
            listener: (context, state) {
              if (state is ArchiveOrderFailure) {
                mySnackBar(Colors.red, 'failure', state.errorMessage);
              }
            },
            builder: (context, state) {
              if (state is ArchiveOrderLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                List<OrderModel> orders = orderCubit.archiveOrders;
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
                        "لا يوجد طلبات مسبقة حالياَ\n اذهب و أضف طلباتك",
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
