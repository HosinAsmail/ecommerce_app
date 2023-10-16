import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:test/cubits/product%20cubit/product_cubit.dart';
import 'package:test/cubits/search%20cubit/search_cubit.dart';
import 'package:test/view/widget/home/search_product_bar.dart';
import 'package:test/view/widget/product/offers_list_view.dart';
import 'package:test/view/widget/search/search_products_grid.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProductCubit productCubit = context.read<ProductCubit>();
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          productCubit.removingGridOfferListener();
          return true;
        },
        child: RefreshIndicator(
          onRefresh: () async {
            productCubit.refreshOffers();
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: [
                const SearchProductBar(),
                BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return Column(
                        children: [
                          SizedBox(
                            height: Get.height / 2,
                          ),
                          const CircularProgressIndicator(),
                        ],
                      );
                    } else if (state is SearchSuccess) {
                      return SearchProductsGrid(
                        products: context.read<SearchCubit>().searchedProducts,
                      );
                    } else if (state is SearchInitial ||
                        state is StartSearching) {
                      return context.read<SearchCubit>().isStartSearching
                          ? const Text('press the search button to get the results')
                          : const OffersListVIew();
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
    );
  }
}
