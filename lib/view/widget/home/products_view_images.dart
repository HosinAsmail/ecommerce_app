import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/core/constant/routes.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_links.dart';
import '../../../data/model/products model/product_model.dart';

class ProductsViewImages extends StatelessWidget {
  const ProductsViewImages({
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
      child: Column(
        children: [
          Image.network(
            "${AppLinks.imageProductsLink}/${productModel.productsImage}",
            height: 100,
          ),
          Text(
            "${productModel.productsName}",
            style: const TextStyle(color: AppColor.black),
          )
        ],
      ),
    );
  }
}
