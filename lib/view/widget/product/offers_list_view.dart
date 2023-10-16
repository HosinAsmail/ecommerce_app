import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:test/cubits/product%20cubit/product_cubit.dart';
import 'package:test/view/widget/product/product_grid.dart';

class OffersListVIew extends StatelessWidget {
  const OffersListVIew({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProductCubit productCubit = context.read<ProductCubit>();

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: Get.height - 150,
        child: ListView(
          controller: productCubit.gridControl,
          children: [
            const ProductsGrid(
              isOffer: true,
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
                  return productCubit.isEnoughOffers()
                      ? const Center(child: CircularProgressIndicator())
                      : Container();
                } else if (state is ProductFailure) {
                  if (state.errorMessage == "no more products to show") {
                    productCubit.setOfferCompleted();
                  }
                  return Center(child: Text(state.errorMessage));
                } else {
                  return Container();
                }
              },
            ),
            const SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }
}
