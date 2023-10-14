import 'package:get/get.dart';
import 'package:test/core/constant/routes.dart';
import 'package:test/cubits/cart%20cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/generated/l10n.dart';

import '../../../core/constant/app_color.dart';

class PriceTableCart extends StatelessWidget {
  const PriceTableCart({
    super.key,
    required this.cartCubit,
  });
  final CartCubit cartCubit;
  @override
  Widget build(BuildContext context) {
    cartCubit.getTotalPrice();
    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (previous, current) {
        if (current is GetAllProductsPriceSuccess) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        double totalAllProductsPrice = cartCubit.totalPrice;
        double totalPrice = totalAllProductsPrice + 10;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.current.products_price,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    "$totalAllProductsPrice\$",
                    style: const TextStyle(fontSize: 20, fontFamily: 'sans'),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).shipping,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Text(
                    "10\$",
                    style: TextStyle(fontSize: 20, fontFamily: 'sans'),
                  )
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.current.total_price,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    "$totalPrice\$",
                    style: const TextStyle(fontSize: 20, fontFamily: 'sans'),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MaterialButton(
                minWidth: double.infinity,
                padding: const EdgeInsets.all(20),
                onPressed: () {
                  Get.toNamed(AppRoute.placeOrderScreen);
                },
                color: AppColor.primaryColor,
                child: Text(
                  S.current.place_order,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
