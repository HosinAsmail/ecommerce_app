import 'package:test/core/constant/app_color.dart';
import 'package:test/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:test/core/functions/translate_from_database.dart';

import '../../../core/constant/app_links.dart';
import '../../../cubits/product cubit/product_cubit.dart';
import '../../../data/model/categories model/categories_model.dart';
class CategoriesViewImages extends StatelessWidget {
  const CategoriesViewImages({
    super.key,
    required this.categoriesModel,
    required this.index,
    required this.categories,
  });
  final int index;

  final CategoriesModel categoriesModel;
  final List<CategoriesModel> categories;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<ProductCubit>()
            .getProduct(index, categoriesModel.categoriesId!,isFirst: true);
        Get.toNamed(AppRoute.productsScreen, arguments: {
          "categories": categories,
        });
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
                color: AppColor.thirdColor,
                borderRadius: BorderRadius.circular(10)),
            height: 70,
            width: 70,
            child: SvgPicture.network(
              "${AppLinks.imageCategoriesLink}/${categoriesModel.categoriesImage}",
              // color: Colors.red,
            ),
          ),
          Text(
            translateFromDatabase(categoriesModel.categoriesNameAr!,
                categoriesModel.categoriesName!),
            style: const TextStyle(color: AppColor.black),
          )
        ],
      ),
    );
  }  
}
