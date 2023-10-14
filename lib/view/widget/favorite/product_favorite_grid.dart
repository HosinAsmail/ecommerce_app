import 'package:test/view/widget/favorite/product_favorite_card.dart';
import 'package:flutter/material.dart';

import '../../../data/model/products model/product_model.dart';

class ProductFavoriteGrid extends StatelessWidget {
  const ProductFavoriteGrid({
    super.key,
    required this.products,
  });
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.only(top: 10),
        itemCount: products.length,
        physics:
            const NeverScrollableScrollPhysics(), // because we are in the list view
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.5, crossAxisCount: 2),
        itemBuilder: (context, index) {
          ProductModel productModel = products[index];
          return ProductFavoriteCard(
            productModel: productModel,
          );
        });
  }
}
