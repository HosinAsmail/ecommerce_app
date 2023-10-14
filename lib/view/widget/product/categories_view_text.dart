import 'package:get/get.dart';
import 'package:test/core/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/core/functions/translate_from_database.dart';

import '../../../cubits/product cubit/product_cubit.dart';
import '../../../data/model/categories model/categories_model.dart';

class CategoriesViewText extends StatelessWidget {
  const CategoriesViewText({
    super.key,
    required this.categories,
  });

  final List<CategoriesModel> categories;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: Get.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...List.generate(categories.length, (index) {
            CategoriesModel categoriesModel = categories[index];
            return GestureDetector(
                onTap: () {
                  context
                      .read<ProductCubit>()
                      .getProduct(index, categoriesModel.categoriesId!);
                },
                child: BlocBuilder<ProductCubit, ProductState>(
                  buildWhen: (previous, current) {
                    if (current is ProductSuccess) {
                      return true;
                    } else {
                      return false;
                    }
                  },
                  builder: (context, state) {
                    int selectedCategory =
                        context.read<ProductCubit>().selected ?? 0;
                    return Container(
                      decoration: BoxDecoration(
                          border: index == selectedCategory
                              ? const Border(
                                  bottom: BorderSide(
                                      width: 3, color: AppColor.primaryColor))
                              : null),
                      padding: const EdgeInsets.only(
                        top: 5,
                        right: 15,
                        left: 15,
                      ),
                      child: Text(
                        translateFromDatabase(categoriesModel.categoriesNameAr!,
                            categoriesModel.categoriesName!),
                        style: const TextStyle(
                            color: AppColor.black, fontSize: 25),
                      ),
                    );
                  },
                ));
          })
        ],
      ),
    );
  }
}
