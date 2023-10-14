import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:test/core/constant/app_color.dart';
import 'package:test/cubits/order%20cubit/order_cubit.dart';
import 'package:test/data/model/cart_model.dart';
import 'package:test/data/model/order_model.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({super.key});

  @override
  Widget build(BuildContext context) {
    OrderModel orderModel = Get.arguments['orderModel'];
    List<CartModel> products = context.read<OrderCubit>().products;
    return Scaffold(
      appBar: AppBar(
        title: const Text("تفاصيل الطلب"),
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderDetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Table(
                          children: [
                            const TableRow(children: [
                              Text(
                                "المنتج",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColor.secondaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "الكمية",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColor.secondaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "السعر ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColor.secondaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                            ...List.generate(
                              products.length,
                              (index) {
                                CartModel cartModel = products[index];
                                return TableRow(children: [
                                  Text(
                                    cartModel.productsNameAr!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(),
                                  ),
                                  Text(
                                    cartModel.cartProductsCount!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(),
                                  ),
                                  Text(
                                    "${cartModel.productsPrice}k SYP ",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(),
                                  ),
                                ]);
                              },
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "سعر المنتجات: ${orderModel.ordersAllprodcutsprice}",
                              style: const TextStyle(
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "تكلفة التوصيل: 10 ",
                              style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                          "السعر الكلي:    ${orderModel.ordersTotalPrice!}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: Card(
                  child: ListTile(
                    title: const Text(
                      "موقع التوصيل",
                      style: TextStyle(
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    subtitle: Text(
                      '${orderModel.addressCity!} ${orderModel.addressStreet!}',
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
