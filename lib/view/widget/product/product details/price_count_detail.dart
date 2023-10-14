import 'package:test/core/constant/app_color.dart';
import 'package:test/cubits/cart%20cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/products model/product_model.dart';

class PriceCountDetail extends StatefulWidget {
  const PriceCountDetail({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  State<PriceCountDetail> createState() => _PriceCountDetailState();
}

class _PriceCountDetailState extends State<PriceCountDetail> {
  @override
  Widget build(BuildContext context) {
    CartCubit cartCubit = context.read<CartCubit>();
    int countNumber = 1;
    final double unitOriginalPrice =
        double.parse(widget.productModel.productsPrice!);
    final double unitDiscountedPrice =
        double.parse(widget.productModel.discountedPrice!);
    late double totalOriginalPrice;
    late double totalDiscountedPrice;

    if (cartCubit.cartProductsTest.containsKey(widget.productModel)) {
      countNumber = cartCubit.cartProductsTest[widget.productModel]!['count'];
    } else {
      cartCubit.cartProductsTest[widget.productModel] = {
        'count': countNumber,
        'totalPrice': unitDiscountedPrice
      };
    }
    totalDiscountedPrice =
        cartCubit.cartProductsTest[widget.productModel]!['totalPrice'];

    totalOriginalPrice = unitOriginalPrice * countNumber;

    return Row(
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              countNumber++;
              totalDiscountedPrice = unitDiscountedPrice * countNumber;
              totalOriginalPrice = unitOriginalPrice * countNumber;
              cartCubit.cartProductsTest[widget.productModel]!['count'] =
                  countNumber;
              cartCubit.cartProductsTest[widget.productModel]!['totalPrice'] =
                  totalDiscountedPrice;
            });
          },
          icon: const Icon(Icons.add),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(bottom: 4),
          height: 30,
          width: 50,
          decoration: BoxDecoration(
              color: AppColor.secondaryColor,
              borderRadius: BorderRadius.circular(2)),
          child: Text(
            '$countNumber',
            style:
                const TextStyle(height: 1.1, fontSize: 25, fontFamily: 'sans'),
          ),
        ),
        IconButton(
          onPressed: () {
            if (countNumber > 1) {
              setState(() {
                countNumber--;
                totalDiscountedPrice = unitDiscountedPrice * countNumber;
                totalOriginalPrice = unitOriginalPrice * countNumber;
                cartCubit.cartProductsTest[widget.productModel]!['count'] =
                    countNumber;
                cartCubit.cartProductsTest[widget.productModel]!['totalPrice'] =
                    totalDiscountedPrice;
              });
            }
          },
          icon: const Icon(Icons.remove),
        ),
        const Spacer(),
        if (widget.productModel.productsDiscount != '0')
          Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 5),
            child: Text(
              "$totalOriginalPrice\$",
              style: const TextStyle(
                fontSize: 22,
                fontFamily: 'sans',
                decoration: TextDecoration.lineThrough,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            "$totalDiscountedPrice\$",
            style: const TextStyle(
                fontSize: 30, fontFamily: 'sans', color: Colors.red),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
