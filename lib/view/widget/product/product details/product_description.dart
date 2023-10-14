import 'package:flutter/material.dart';
import 'package:test/core/functions/translate_from_database.dart';

import '../../../../data/model/products model/product_model.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${translateFromDatabase(productModel.productsDescriptionAr!, productModel.productsDescription!)} ${translateFromDatabase(productModel.productsDescriptionAr!, productModel.productsDescription!)}${translateFromDatabase(productModel.productsDescriptionAr!, productModel.productsDescription!)}${translateFromDatabase(productModel.productsDescriptionAr!, productModel.productsDescription!)}${translateFromDatabase(productModel.productsDescriptionAr!, productModel.productsDescription!)}${translateFromDatabase(productModel.productsDescriptionAr!, productModel.productsDescription!)}${translateFromDatabase(productModel.productsDescriptionAr!, productModel.productsDescription!)}${translateFromDatabase(productModel.productsDescriptionAr!, productModel.productsDescription!)}",
      style: Theme.of(context)
          .textTheme
          .displayMedium!
          .copyWith(fontWeight: FontWeight.normal),
    );
  }
}
