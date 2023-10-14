import 'package:test/core/functions/translate_from_database.dart';
import 'package:test/data/model/products%20model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant/app_color.dart';
import '../../../cubits/cart cubit/cart_cubit.dart';

class ControlCountCart extends StatefulWidget {
  const ControlCountCart({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;
  @override
  State<ControlCountCart> createState() => _ControlCountCartState();
}

class _ControlCountCartState extends State<ControlCountCart> {
  @override
  Widget build(BuildContext context) {
    CartCubit cartCubit = context.read<CartCubit>();
    int countNumber = cartCubit.cartProducts[widget.productModel]!['count'];
    final double unitDiscountedPrice =
        double.parse(widget.productModel.discountedPrice!);
    final double totalDiscountedPrice =
        cartCubit.cartProducts[widget.productModel]!['totalPrice'];

    return Expanded(
      flex: 6,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: ListTile(
              title: Text(
                  translateFromDatabase(widget.productModel.productsNameAr!,
                      widget.productModel.productsName!),
                  style: const TextStyle(fontSize: 18)),
              subtitle: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  '${widget.productModel.discountedPrice!} x $countNumber = $totalDiscountedPrice\$',
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'sans',
                    color: AppColor.primaryColor,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          countNumber++;
                          cartCubit
                                  .cartProducts[widget.productModel]!['count'] =
                              countNumber;
                          cartCubit.cartProducts[widget.productModel]![
                              'totalPrice'] = unitDiscountedPrice * countNumber;
                        });
                        cartCubit.getTotalPrice();
                      },
                      icon: const Icon(Icons.add)),
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      '$countNumber',
                      style: const TextStyle(
                          fontFamily: 'sans',
                          height: 1.1,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (countNumber > 1) {
                          setState(() {
                            countNumber--;
                            cartCubit.cartProducts[widget.productModel]![
                                'count'] = countNumber;
                            cartCubit.cartProducts[widget.productModel]![
                                    'totalPrice'] =
                                unitDiscountedPrice * countNumber;
                          });
                          cartCubit.getTotalPrice();
                        }
                      },
                      icon: const Icon(Icons.remove))
                ],
              )),
        ],
      ),
    );
  }
}
