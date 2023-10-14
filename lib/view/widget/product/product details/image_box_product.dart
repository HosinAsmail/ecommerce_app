import 'package:test/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/core/services/storage%20services/store_language_service.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_links.dart';
import '../../../../data/model/products model/product_model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ImageBoxProduct extends StatelessWidget {
  const ImageBoxProduct({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    bool isArabic = StoreLanguageService().getLocale() == const Locale('ar');
    isArabic = true;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 200,
          color: AppColor.thirdColor,
        ),
        Positioned(
          bottom: -30,
          left: 50,
          right: 50,
          child: Hero(
            tag: productModel.productsId!,
            child: Image.network(
              "${AppLinks.imageProductsLink}/${productModel.productsImage}",
              height: 200,
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
            )),
        Positioned(
            right: isArabic ? null : 10,
            left: isArabic ? 10 : null,
            child: IconButton(
                onPressed: () {
                  Get.offAllNamed(AppRoute.baseScreen,
                      arguments: {'initialIndex': 3});
                },
                icon: Icon(
                  MdiIcons.cart,
                  size: 30,
                )))
      ],
    );
  }
}
