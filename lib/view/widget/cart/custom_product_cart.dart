import 'package:test/core/functions/alert_dialog.dart';
import 'package:test/cubits/cart%20cubit/cart_cubit.dart';
import 'package:test/view/widget/cart/control_count_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../core/constant/app_links.dart';
import '../../../data/model/products model/product_model.dart';

class CustomProductCart extends StatelessWidget {
  const CustomProductCart({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
          child: SizedBox(
        height: 120,
        child: Row(
          children: [
            Expanded(
                child: IconButton(
              onPressed: () {
                alertDialog(
                    context: context,
                    title: "Warning",
                    content:
                        'are you sure you want to remove this product from the cart ?',
                    confirmText: 'remove from Cart',
                    confirmButtonColor:
                        const Color.fromARGB(255, 255, 173, 167),
                    onPressed: () {
                      context.read<CartCubit>().deleteCart(productModel);
                      Get.back();
                    });
              },
              icon: const Icon(
                Icons.delete,
                size: 30,
                color: Colors.red,
              ),
            )),
            Expanded(
                flex: 3,
                child: Image.network(
                  '${AppLinks.imageProductsLink}/${productModel.productsImage}',
                  fit: BoxFit.fill,
                )),
            ControlCountCart(
              productModel: productModel,
            )
          ],
        ),
      )),
    );
  }
}
