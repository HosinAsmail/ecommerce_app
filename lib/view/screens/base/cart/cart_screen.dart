import 'package:test/core/constant/app_color.dart';
import 'package:test/core/functions/alert_loading.dart';
import 'package:test/cubits/cart%20cubit/cart_cubit.dart';
import 'package:test/data/model/products%20model/product_model.dart';
import 'package:test/generated/l10n.dart';
import 'package:test/view/widget/cart/custom_cart_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/functions/my_snack_bar.dart';
import '../../../../core/functions/close_loading_dialog.dart';
import '../../../widget/cart/custom_product_cart.dart';
import '../../../widget/cart/price_table_cart.dart';
import '../../../widget/cart/top_cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CartCubit cartCubit = context.read<CartCubit>();
    cartCubit.cartProducts.isEmpty ? cartCubit.getAsyncCart() : null;
    return RefreshIndicator(
        onRefresh: () => cartCubit.getAsyncCart(),
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is GetCartFailure) {
              closeLoadingDialog();
              mySnackBar(AppColor.failureColor, 'failed', state.errorMessage);
            } else if (state is GetCartLoading) {
              alertLoading();
            } else if (state is GetCartSuccess) {
              closeLoadingDialog();
            }
          },
          buildWhen: (previous, current) {
            if (current is DeleteCartSuccess ||
                current is CartInitial ||
                current is GetCartSuccess ||
                current is GetCartFailure) {
              return true;
            } else {
              return false;
            }
          },
          builder: (context, state) {
            if (state is GetCartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetCartFailure || state is GetCartLoading || state is DeleteCartSuccess) {
              return ListView(
                children: [
                  const CustomCartBar(),
                  TopCart(text: S.current.no_cart_products),
                  SizedBox(
                    height: Get.height / 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      S.current.no_cart_products,
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(fontSize: 20, color: AppColor.black),
                    ),
                  )
                ],
              );
            } else {
              List<ProductModel> products = [];
              for (final entry in cartCubit.cartProducts.entries) {
                products.add(entry.key);
              }
              return ListView(
                children: [
                  const CustomCartBar(),
                  TopCart(
                      text: S.current
                          .you_have_products_added_to_cart(products.length)),
                  ListView.builder(
                      itemCount: products.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        ProductModel productModel = products[index];
                        return CustomProductCart(productModel: productModel);
                      }),
                  PriceTableCart(
                    cartCubit: cartCubit,
                  )
                ],
              );
            }
          },
        ));
  }
}
