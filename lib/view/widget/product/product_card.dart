import 'package:test/core/constant/app_color.dart';
import 'package:test/core/constant/app_links.dart';
import 'package:test/core/constant/routes.dart';
import 'package:test/core/functions/alert_dialog.dart';
import 'package:test/core/functions/translate_from_database.dart';
import 'package:test/core/services/shape%20services/custom_star_discount.dart';
import 'package:test/cubits/cart%20cubit/cart_cubit.dart';
import 'package:test/cubits/favorite%20cubit/favorite_cubit.dart';
import 'package:test/cubits/search%20cubit/search_cubit.dart';
import 'package:test/data/model/products%20model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoute.productDetailsScreen,
            arguments: {'productModel': productModel});
      },
      child: Card(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: productModel.productsId!,
                  child: Image.network(
                    "${AppLinks.imageProductsLink}/${productModel.productsImage}",
                    height: 120,
                  ),
                ),
                Text(
                  translateFromDatabase(
                      productModel.productsNameAr!, productModel.productsName!),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  translateFromDatabase(productModel.productsDescriptionAr!,
                      productModel.productsDescription!),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Row(
                  children: [
                    if (productModel.productsDiscount != "0")
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            "${productModel.productsPrice!}\$",
                            style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.red,
                                fontFamily: 'sans',
                                // fontSize: ,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "${productModel.discountedPrice!}\$",
                        style: const TextStyle(
                            fontSize: 16,
                            color: AppColor.primaryColor,
                            fontFamily: 'sans',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          return context
                                      .read<CartCubit>()
                                      .cartProducts[productModel] ==
                                  null
                              ? const Text('')
                              : IconButton(
                                  onPressed: () {
                                    alertDialog(
                                        context: context,
                                        title: 'ملاحظة',
                                        content: "هذا المنتج مٌضاف إلى السلة",
                                        confirmText: 'إزالة من السلة',
                                        onPressed: () {
                                          Get.back();
                                          context
                                              .read<CartCubit>()
                                              .deleteCart(productModel);
                                        });
                                  },
                                  icon: Icon(
                                    MdiIcons.cart,
                                    color: AppColor.primaryColor,
                                  ));
                        },
                        buildWhen: (previous, current) {
                          // this failure states are added to remove or readd the cart button after adding it as a result of a server failure
                          if (current is DeleteCartSuccess ||
                              current is AddCartFailure ||
                              current is DeleteCartFailure ||
                              current is AddCartSuccess) {
                            return true;
                          } else {
                            return false;
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: BlocBuilder<FavoriteCubit, FavoriteState>(
                        builder: (context, state) {
                          FavoriteCubit favoriteCubit =
                              context.read<FavoriteCubit>();
                          return IconButton(
                              onPressed: () {
                                if (productModel.favorite == '1') {
                                  productModel.favorite = '0';
                                  favoriteCubit.deleteFavorite(productModel);
                                } else {
                                  productModel.favorite = '1';
                                  favoriteCubit.addFavorite(productModel);
                                }
                              },
                              icon: Icon(
                                productModel.favorite == "1"
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color: AppColor.primaryColor,
                              ));
                        },
                        buildWhen: (previous, current) {
                          if (current is AddFavoriteSuccess ||
                              current is FavoriteInitial ||
                              current is DeleteFavoriteSuccess ||
                              current is SearchSuccess) {
                            return true;
                          } else {
                            return false;
                          }
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
            if (productModel.productsDiscount != "0")
              Positioned(
                top: 0, // Adjust the position as needed
                child: ClipPath(
                  clipper: StarClipper(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color:
                          Colors.red, // Background color for the discount mark
                      borderRadius:
                          BorderRadius.circular(8), // Customize the shape
                    ),
                    child: Text(
                      "${productModel.productsDiscount}% OFF", // Replace with your discount value
                      style: const TextStyle(
                        fontFamily: 'sans',
                        color: Colors.white, // Text color
                        fontWeight: FontWeight.bold, // Text style
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
