import 'package:test/core/functions/alert_dialog.dart';
import 'package:test/cubits/cart%20cubit/cart_cubit.dart';
import 'package:test/data/model/products%20model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:test/generated/l10n.dart';

import '../../../../core/constant/app_color.dart';

class AddToCardButton extends StatelessWidget {
  const AddToCardButton({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    bool isAdded = false;
    if (context.read<CartCubit>().cartProducts[productModel] != null) {
      isAdded =
          context.read<CartCubit>().cartProducts[productModel]!["isAdded"] ??
              false;
    }
    return Container(
      margin: const EdgeInsets.all(10),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () {
          alertDialog(
              context: context,
              title: 'عظيم',
              content: isAdded
                  ? "هل أنت متأكد بأنك تريد تريد إزالة هذا المنتج من السلة؟"
                  : 'هل أنهيت كل التفاصيل المتعلقة بهذا الطلب؟',
              confirmText: isAdded ? 'إزالة من السلة' : 'إضافة إلى السلة',
              onPressed: () {
                Get.back();
                if (isAdded) {
                  context.read<CartCubit>().deleteCart(productModel);
                } else {
                  context.read<CartCubit>().addCart(productModel);
                }
              });
        },
        color: isAdded ? Colors.redAccent : AppColor.secondaryColor,
        child: Text(
          isAdded ? S.current.remove_from_cart : S.current.add_to_cart,
          style:
              Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 20),
        ),
      ),
    );
  }
}
