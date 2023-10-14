import 'package:test/data/model/products%20model/product_model.dart';
import 'package:test/view/widget/product/product_card.dart';
import 'package:flutter/material.dart';

class SearchProductsGrid extends StatelessWidget {
  const SearchProductsGrid({
    super.key,
    required this.products
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
            childAspectRatio: 0.6, crossAxisCount: 2),
        itemBuilder: (context, index) {
          ProductModel productModel = products[index];
          return ProductCard(
            productModel: productModel,
          );
        });
  }
}
