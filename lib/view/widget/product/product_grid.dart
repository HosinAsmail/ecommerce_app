import 'package:test/cubits/product%20cubit/product_cubit.dart';
import 'package:test/data/model/products%20model/product_model.dart';
import 'package:test/view/widget/product/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    super.key,
    required this.isOffer,
  });
  final bool isOffer;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      buildWhen: (previous, current) {
        if (current is ProductFailure ||
            current is ProductSuccess ||
            (current is ProductLoading && current.isFirstGetData == true)) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        if (state is ProductLoading) {
          return const SizedBox(
            height: 300,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ProductSuccess || state is ProductFailure) {
          List<ProductModel> products = [];
          if (isOffer) {
            products = context.read<ProductCubit>().offers;
          } else {
            String categoriesId = context.read<ProductCubit>().categoryId!;
            products =
                context.read<ProductCubit>().categoryProducts[categoriesId] ==
                        null
                    ? []
                    : context
                        .read<ProductCubit>()
                        .categoryProducts[categoriesId]!["products"];
          }
          return products.isEmpty
              ? const Center(child: Text('no data'))
              : GridView.builder(
                  // padding: const EdgeInsets.only(top: 10),
                  itemCount: products.length,
                  physics:
                      const NeverScrollableScrollPhysics(), // because we are in the list view
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.57, crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    ProductModel productModel = products[index];
                    return ProductCard(
                      productModel: productModel,
                    );
                  });
        } else {
          return const Text("unexpected behavior");
        }
      },
    );
  }
}
