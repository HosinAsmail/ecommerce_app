import 'package:test/core/constant/app_color.dart';
import 'package:test/core/constant/app_links.dart';
import 'package:test/core/functions/translate_from_database.dart';
import 'package:test/cubits/favorite%20cubit/favorite_cubit.dart';
import 'package:test/data/model/products%20model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../core/constant/routes.dart';

class ProductFavoriteCard extends StatelessWidget {
  const ProductFavoriteCard({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoute.productDetailsScreen,
            arguments: {'productModel': productModel});
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: productModel.productsId!,
              child: Image.network(
                "${AppLinks.imageProductsLink}/${productModel.productsImage}",
                height: 150,
              ),
            ),
            Text(
              translateFromDatabase(
                  productModel.productsNameAr!, productModel.productsName!),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              translateFromDatabase(productModel.productsDescriptionAr!,
                  productModel.productsDescription!),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${productModel.discountedPrice!}\$",
                  style: const TextStyle(
                      color: AppColor.primaryColor,
                      fontFamily: 'sans',
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      Get.defaultDialog(
                          onCancel: () {
                            Get.back();
                          },
                          onConfirm: () {
                            Get.back();
                            context
                                .read<FavoriteCubit>()
                                .deleteFavorite(productModel);
                          },
                          title: 'Warning!!',
                          middleText:
                              'are you sure you want to remove this product from favorite ');
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: AppColor.primaryColor,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
