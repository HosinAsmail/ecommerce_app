import 'package:test/core/constant/app_color.dart';
import 'package:test/core/functions/alert_exit.dart';
import 'package:test/core/functions/my_snack_bar.dart';
import 'package:test/view/screens/base/cart/cart_screen.dart';
import 'package:test/view/screens/base/favorite_screen.dart';
import 'package:test/view/screens/base/home_screen.dart';
import 'package:test/view/screens/base/order/order_screen.dart';
import 'package:test/view/screens/base/settings_screen.dart';
import 'package:test/view/widget/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../cubits/home cubit/home_cubit.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int initialIndex = Get.arguments['initialIndex'];
    return DefaultTabController(
      length: 5,
      initialIndex: initialIndex,
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeFailure) {
            mySnackBar(AppColor.failureColor, 'failed', state.errorMessage);
          }
        },
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          } else {
            return const Scaffold(
              body: WillPopScope(
                onWillPop: alertExit,
                child: TabBarView(
                  children: [
                    SettingsScreen(),
                    FavoriteScreen(),
                    HomeScreen(),
                    CartScreen(),
                    OrderScreen(),
                  ],
                ),
              ),
              bottomNavigationBar: CustomBottomBar(),
            );
          }
        },
      ),
    );
  }
}
