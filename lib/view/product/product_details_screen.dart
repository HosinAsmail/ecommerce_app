import 'package:test/core/functions/translate_from_database.dart';
import 'package:test/cubits/cart%20cubit/cart_cubit.dart';
import 'package:test/data/model/products%20model/product_model.dart';
import 'package:test/view/widget/home/custom_text_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../core/constant/app_color.dart';
import '../../core/functions/my_snack_bar.dart';
import '../widget/product/product details/add_to_cart_button.dart';
import '../widget/product/product details/image_box_product.dart';
import '../widget/product/product details/price_count_detail.dart';
import '../widget/product/product details/product_description.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final ProductModel productModel = arguments['productModel'];
    return Scaffold(
      bottomNavigationBar: AddToCardButton(
        productModel: productModel,
      ),
      body: SafeArea(
        child: BlocListener<CartCubit, CartState>(
          listener: (context, state) {
            if (state is AddCartSuccess) {
              Get.back();
              mySnackBar(AppColor.successColor, 'success',
                  'successfully added to the cart');
            } else if (state is AddCartFailure) {
              mySnackBar(AppColor.failureColor, 'failed to add to the cart',
                  state.errorMessage);
            } else if (state is DeleteCartSuccess) {
              Get.back();
              mySnackBar(AppColor.secondaryColor, 'Deleted',
                  'the product has been deleted from the cart successfully');
            } else if (state is DeleteCartFailure) {
              mySnackBar(AppColor.failureColor,
                  'failed to delete from the cart', state.errorMessage);
            }
          },
          child: ListView(
            children: [
              ImageBoxProduct(productModel: productModel),
              Container(
                padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    CustomTextHome(
                      text: translateFromDatabase(productModel.productsNameAr!,
                          productModel.productsName!),
                    ),
                    PriceCountDetail(productModel: productModel),
                    ProductDescription(productModel: productModel),
                    // const CustomTextHome(text: 'Choose Color'),
                    // SizedBox(
                    //   height: 70,
                    //   child: ListView(
                    //     scrollDirection: Axis.horizontal,
                    //     children: [
                    //       ...List.generate(
                    //           3,
                    //           (index) => Container(
                    //                 alignment: Alignment.center,
                    //                 margin: const EdgeInsets.all(10),
                    //                 height: 70,
                    //                 width: 100,
                    //                 decoration: BoxDecoration(
                    //                     color: Colors.blue,
                    //                     border: Border.all(),
                    //                     borderRadius:
                    //                         BorderRadius.circular(10)),
                    //                 child: const Text(
                    //                   "red",
                    //                   style: TextStyle(color: Colors.white),
                    //                 ),
                    //               ))
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
