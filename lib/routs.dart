import 'package:test/core/constant/routes.dart';
import 'package:test/core/midleware/my_middleware.dart';
import 'package:test/view/screens/auth/forget%20password/forget_password_screen.dart';
import 'package:test/view/screens/auth/login_screen.dart';
import 'package:test/view/screens/auth/forget%20password/reset_password_screen.dart';
import 'package:test/view/screens/auth/signup_screen.dart';
import 'package:test/view/screens/auth/success_auth_screen.dart';
import 'package:test/view/screens/auth/forget%20password/verify_code_sceen.dart';
import 'package:test/view/screens/base/base_screen.dart';
import 'package:test/view/screens/base/cart/cart_screen.dart';
import 'package:test/view/screens/base/cart/place_order_screen.dart';
import 'package:test/view/screens/base/favorite_screen.dart';
import 'package:test/view/screens/base/home_screen.dart';
import 'package:test/view/product/products_screen.dart';
import 'package:test/view/screens/base/offers_screen.dart';
import 'package:test/view/screens/base/order/order_archieve_screen.dart';
import 'package:test/view/screens/base/order/order_details_screen.dart';
import 'package:test/view/screens/base/order/order_pending_screen.dart';
import 'package:test/view/screens/language_screen.dart';
import 'package:test/view/screens/onboarding_screen.dart';
import 'package:test/view/product/product_details_screen.dart';
import 'package:get/get.dart';
import 'package:test/view/screens/settings/address_screen.dart';
import 'package:test/view/screens/settings/notification_screen.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
      name: "/",
      page: () => const LanguageScreen(),
      middlewares: [MyMiddleWare()]),
  GetPage(name: AppRoute.loginScreen, page: () => const LoginScreen()),
  GetPage(name: AppRoute.signUpScreen, page: () => const SignUpScreen()),
  GetPage(
      name: AppRoute.forgetPasswordScreen,
      page: () => const ForgetPasswordScreen()),
  GetPage(
      name: AppRoute.verifyCodeScreen, page: () => const VerifyCodeScreen()),
  GetPage(
      name: AppRoute.resetPasswordScreen,
      page: () => const ResetPasswordScreen()),
  GetPage(
      name: AppRoute.successAuthScreen, page: () => const SuccessAuthScreen()),
  GetPage(
      name: AppRoute.onBoardingScreen, page: () => const OnBoardingScreen()),
  GetPage(name: AppRoute.baseScreen, page: () => const BaseScreen()),
  GetPage(name: AppRoute.homeScreen, page: () => const HomeScreen()),
  GetPage(name: AppRoute.productsScreen, page: () => const ProductScreen()),
  GetPage(
      name: AppRoute.notificationScreen,
      page: () => const NotificationScreen()),
  GetPage(
      name: AppRoute.productDetailsScreen,
      page: () => const ProductDetailsScreen()),
  GetPage(name: AppRoute.offersScreen, page: () => const OffersScreen()),
  GetPage(name: AppRoute.favoriteScreen, page: () => const FavoriteScreen()),
  GetPage(name: AppRoute.detailOrderScreen, page: () => const OrderDetail()),
  GetPage(name: AppRoute.cartScreen, page: () => const CartScreen()),
  GetPage(name: AppRoute.addressScreen, page: () => const AddressScreen()),
  GetPage(
      name: AppRoute.orderPendingScreen,
      page: () => const OrderPendingScreen()),
  GetPage(
      name: AppRoute.orderArchiveScreen,
      page: () => const OrderArchiveScreen()),
  GetPage(
      name: AppRoute.placeOrderScreen, page: () => const PlaceOrderScreen()),
];
