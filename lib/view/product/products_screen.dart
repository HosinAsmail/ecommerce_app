import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubits/product%20cubit/product_cubit.dart';
import 'package:test/cubits/search%20cubit/search_cubit.dart';
import 'package:test/data/model/categories%20model/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/view/widget/product/products_list_view.dart';
import 'package:test/view/widget/search/search_products_grid.dart';
import '../widget/home/search_product_bar.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    List<CategoriesModel> categories = arguments["categories"];

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<ProductCubit>().getAsyncProduct();
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: Get.height,
              width: Get.width,
              child: Column(
                children: [
                  const SearchProductBar(),
                  BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      if (state is SearchLoading) {
                        return const Column(
                          children: [
                            SizedBox(
                              height: 200,
                            ),
                            CircularProgressIndicator(),
                          ],
                        );
                      } else if (state is SearchSuccess) {
                        // TODO: fix the scrolling pagination
                        return SearchProductsGrid(
                          products:
                              context.read<SearchCubit>().searchedProducts,
                        );
                      } else if (state is SearchInitial ||
                          state is StartSearching) {
                        return context.read<SearchCubit>().isStartSearching
                            ? const Text('')
                            : ProductsListView(categories: categories);
                      } else if (state is SearchFailure) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 200,
                            ),
                            Text(
                              state.errorMessage,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

