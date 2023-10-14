import 'package:test/cubits/favorite%20cubit/favorite_cubit.dart';
import 'package:test/view/widget/favorite/product_favorite_grid.dart';
import 'package:test/view/widget/home/search_product_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/functions/my_snack_bar.dart';
import '../../../data/model/products model/product_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FavoriteCubit favoriteCubit = context.read<FavoriteCubit>();
    favoriteCubit.getFavorite();
    return RefreshIndicator(
      onRefresh: () async {
        favoriteCubit.getAsyncFavorite();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            const SearchProductBar(),
            BlocConsumer<FavoriteCubit, FavoriteState>(
              listener: (context, state) {
                if (state is GetFavoriteFailure) {
                  mySnackBar(
                      AppColor.failureColor, "failed", state.errorMessage);
                } else if (state is DeleteFavoriteFailure) {
                  mySnackBar(
                      AppColor.failureColor, "failed", state.errorMessage);
                }
              },
              builder: (context, state) {
                List<ProductModel> products = favoriteCubit.favoriteProducts;
                if (state is GetFavoriteLoading ||
                    state is DeleteFavoriteLoading) {
                  return const SizedBox(
                    height: 600,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is GetFavoriteSuccess ||
                    state is DeleteFavoriteFailure ||
                    state is DeleteFavoriteSuccess) {
                  return ProductFavoriteGrid(
                    products: products,
                  );
                } else {
                  return const Center(child: Text("failed"));
                }
              },
              buildWhen: (previous, current) {
                if (current is GetFavoriteLoading ||
                    current is GetFavoriteSuccess ||
                    current is GetFavoriteFailure ||
                    current is DeleteFavoriteFailure ||
                    current is DeleteFavoriteLoading ||
                    current is DeleteFavoriteSuccess) {
                  return true;
                } else {
                  return false;
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
