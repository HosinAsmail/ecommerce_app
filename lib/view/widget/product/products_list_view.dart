import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:test/cubits/product%20cubit/product_cubit.dart';
import 'package:test/data/model/categories%20model/categories_model.dart';
import 'package:test/view/widget/product/categories_view_text.dart';
import 'package:test/view/widget/product/product_grid.dart';

class ProductsListView extends StatelessWidget {
  const ProductsListView({
    super.key,
    required this.categories,
  });

  final List<CategoriesModel> categories;

  @override
  Widget build(BuildContext context) {
    ProductCubit productCubit = context.read<ProductCubit>();

    productCubit.addingGridListener();
    return Column(
      children: [
        CategoriesViewText(
          categories: categories,
        ),
        SizedBox(
          height: Get.height - 194,
          child: ListView(
            controller: productCubit.gridControl,
            children: [
              const ProductsGrid(
                isOffer: false,
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<ProductCubit, ProductState>(
                buildWhen: (previous, current) {
                  if (current is ProductFailure || current is ProductSuccess) {
                    return true;
                  } else {
                    return false;
                  }
                },
                //? hello what are you doing?
                //! wrong
                //*dd
                builder: (context, state) {
                  if (state is ProductSuccess) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductFailure) {
                    if (state.errorMessage == "no more products to show") {
                      productCubit.removingGridListener();
                    }
                    return Center(child: Text(state.errorMessage));
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
