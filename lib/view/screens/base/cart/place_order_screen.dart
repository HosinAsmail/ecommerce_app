import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:test/core/constant/app_color.dart';
import 'package:test/core/constant/routes.dart';
import 'package:test/core/functions/alert_loading.dart';
import 'package:test/core/functions/close_loading_dialog.dart';
import 'package:test/core/functions/my_snack_bar.dart';
import 'package:test/cubits/address%20cubit/address_cubit.dart';
import 'package:test/cubits/cart%20cubit/cart_cubit.dart';
import 'package:test/cubits/order%20cubit/order_cubit.dart';
import 'package:test/data/model/address_model.dart';
import 'package:test/view/widget/cart/address_choose_info.dart';
import 'package:test/view/widget/home/custom_text_home.dart';

class PlaceOrderScreen extends StatelessWidget {
  const PlaceOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AddressCubit addressCubit = context.read<AddressCubit>();
    addressCubit.getAddress();
    List<AddressModel> addresses = addressCubit.addresses;

    return Scaffold(
      appBar: AppBar(title: const Text("details")),
      body: BlocListener<OrderCubit, OrderState>(
        listener: (context, state) {
          if (state is PlaceOrderLoading) {
            alertLoading();
          } else if (state is PlaceOrderFailure) {
            closeLoadingDialog();
            mySnackBar(Colors.red, 'Failure', state.errorMessage);
          } else if (state is PlaceOrderSuccess) {
            closeLoadingDialog();
            Get.offAllNamed(AppRoute.baseScreen,
                arguments: {"initialIndex": 4});
            mySnackBar(AppColor.successColor, 'success',
                'follow you order state here');
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomTextHome(text: 'اختر موقعك الذي تفضله'),
            Container(
              margin: const EdgeInsets.all(15),
              width: 500,
              height: 300,
              child: BlocBuilder<AddressCubit, AddressState>(
                builder: (context, state) {
                  return ListView.builder(
                      itemCount: addresses.length,
                      itemBuilder: (context, index) {
                        AddressModel addressModel = addresses[index];

                        return Container(
                          height: 100,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: addressCubit.selectedLocation == index
                                  ? AppColor.primaryColor
                                  : AppColor.thirdColor),
                          child: AddressChooseInfo(
                            index: index,
                            addressModel: addressModel,
                          ),
                        );
                      });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: MaterialButton(
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  if (addressCubit.selectedLocation != null) {
                    context.read<OrderCubit>().placeOrder(
                        "10", context.read<CartCubit>().totalPrice.toString());
                    context.read<CartCubit>().cartProducts.clear();
                    context.read<CartCubit>().cartProductsTest.clear();

                  } else {
                    mySnackBar(AppColor.secondaryColor, 'Be careful',
                        'please choose the preferred location first');
                  }
                },
                color: AppColor.primaryColor,
                child: const Text(
                  'place order',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
