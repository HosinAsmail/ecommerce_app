import 'package:get/get.dart';
import 'package:test/core/constant/routes.dart';
import 'package:test/cubits/product%20cubit/product_cubit.dart';
import 'package:test/data/model/ad_model.dart';
import 'package:test/data/model/categories%20model/categories_model.dart';
import 'package:test/data/model/products%20model/product_model.dart';
import 'package:test/generated/l10n.dart';
import 'package:test/view/widget/home/search_product_bar.dart';
import 'package:test/view/widget/home/surprise_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/home cubit/home_cubit.dart';
import '../../widget/home/categories_view_images.dart';
import '../../widget/home/custom_text_home.dart';
import '../../widget/home/products_view_images.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    //  homeCubit.getData();
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: RefreshIndicator(
          onRefresh: () => context.read<HomeCubit>().getAsyncData(),
          child: ListView(
            children: [
              const SearchProductBar(),
              SizedBox(
                height: 155,
                width: 200,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: homeCubit.ads.length,
                    itemBuilder: (context, index) {
                      AdModel adModel = homeCubit.ads[index];
                      return SurpriseBox(
                        adModel: adModel,
                      );
                    }),
              ),
              CustomTextHome(
                text: S.of(context).categories_word,
              ),
              SizedBox(
                height: 120,
                child: ListView.builder(
                    itemCount: homeCubit.categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      List<CategoriesModel> categories = homeCubit.categories;
                      CategoriesModel categoriesModel = categories[index];
                      return CategoriesViewImages(
                          categories: categories,
                          index: index,
                          categoriesModel: categoriesModel);
                    }),
              ),
              CustomTextHome(
                text: S.of(context).top_selling,
              ),
              SizedBox(
                height: 150,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: homeCubit.topSelling.length,
                    itemBuilder: ((context, index) {
                      ProductModel productModel =
                          context.read<HomeCubit>().topSelling[index];
                      return ProductsViewImages(productModel: productModel);
                    })),
              ),
              Row(
                children: [
                  CustomTextHome(
                    text: S.of(context).offer,
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoute.offersScreen);
                        context.read<ProductCubit>().getOffers();
                      },
                      child: const Text('المزيد'))
                ],
              ),
              SizedBox(
                height: 150,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: homeCubit.offeredProducts.length,
                    itemBuilder: ((context, index) {
                      ProductModel productModel =
                          context.read<HomeCubit>().offeredProducts[index];
                      return ProductsViewImages(productModel: productModel);
                    })),
              )
            ],
          ),
        ));
  }
}
