import 'package:bloc/bloc.dart';
import 'package:test/core/functions/check_internet_function.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:test/core/services/storage%20services/store_all_data.dart';
import '../../core/api/crud.dart';
import '../../core/functions/handling_failure_response.dart';
import '../../data/data source/remote/cart/cart_remote.dart';
import '../../data/model/products model/product_model.dart';
import '../../data/model/user model/user_model.dart';
import 'package:test/core/extension/number_extensions.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  Crud crud = Crud();
  StoreAllData storeAllData = StoreAllData();
  UserModel userModel = UserModel.instance;
  Map<ProductModel, Map<String, dynamic>> cartProductsTest = {};
  Map<ProductModel, Map<String, dynamic>> cartProducts =
      {}; // {    "productModel": {"count": "3", "totalPrice": "20/\$"} }
  double totalPrice = 0;
  void addCart(ProductModel productModel) async {
    emit(AddCartLoading());
    if (await checkInternetFunction() == true) {
      emit(AddCartSuccess());
      try {
        cartProducts[productModel] = cartProductsTest[productModel]!;
        CartRemote cartRemote = CartRemote(crud);
        var response = await cartRemote.addCart(
            productModel.productsId!,
            userModel.userId,
            cartProducts[productModel]!['count'].toString(),
            cartProducts[productModel]!['totalPrice'].toString());
        String? failureMessage = handlingFailureMessage(response, "no data");
        if (failureMessage != null) {
          cartProducts.remove(productModel);
          emit(AddCartFailure(errorMessage: failureMessage));
        } else {
          cartProducts[productModel]!['isAdded'] = true;
        }
      } on Exception catch (e) {
        cartProducts.remove(productModel);
        if (e is ClientException) {
          emit(const AddCartFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(
            AddCartFailure(errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      emit(const AddCartFailure(
          errorMessage:
              "you are offline please turn on the internet and try again"));
    }
  }

  void deleteCart(ProductModel productModel) async {
    emit(DeleteCartLoading());
    if (await checkInternetFunction() == true) {
      cartProducts.remove(productModel);
      emit(DeleteCartSuccess());
      try {
        CartRemote cartRemote = CartRemote(crud);
        var response = await cartRemote.deleteCart(
            productModel.productsId!, userModel.userId);
        String? failureMessage = handlingFailureMessage(response, "no data");
        if (failureMessage != null) {
          emit(DeleteCartFailure(errorMessage: failureMessage));
        }
      } on Exception catch (e) {
        if (e is ClientException) {
          emit(const DeleteCartFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(DeleteCartFailure(
            errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      emit(const DeleteCartFailure(
          errorMessage:
              "you are offline please turn on the internet and try again"));
    }
  }

  Future<void> getAsyncCart() async {
    emit(GetCartLoading());
    if (await checkInternetFunction()) {
      try {
        cartProducts.clear();
        CartRemote cartRemote = CartRemote(crud);
        var response = await cartRemote.getCart(userModel.userId);
        if (response is Map<String, dynamic>) {
          cartProducts.clear();
          for (final product in response['products']) {
            ProductModel productModel =
                ProductModel.fromJson(product['product_model']);
            cartProducts[productModel] = {
              'count':
                 product['price_and_count']['cart_products_count'].toInt(),
              'totalPrice':
                  product['price_and_count']['cart_total_product_price'].toDouble()
            };
          }
        }
        String? failureMessage = handlingFailureMessage(response, "no data");
        if (failureMessage != null) {
          emit(GetCartFailure(errorMessage: failureMessage));
        } else {
          emit(GetCartSuccess());
        }
      } on Exception catch (e) {
        if (e is ClientException) {
          emit(const GetCartFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(
            GetCartFailure(errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      emit(const GetCartFailure(
          errorMessage:
              "you are offline please turn on the internet and try again"));
    }
  }

  void getCart() {
    emit(GetCartLoading());
    emit(GetCartSuccess());
  }

  void getTotalPrice() async {
    emit(GetAllProductsPriceLoading());
    totalPrice = 0;
    for (final entry in cartProducts.entries) {
      totalPrice += entry.value['totalPrice'];
    }
    emit(GetAllProductsPriceSuccess());
  }
//  placeOrder(String priceDelivery, String addressId) async {
//     if (await checkInternetFunction()) {
//       OrderRemote orderRemote = OrderRemote(crud);
//       orderRemote.placeOrder(
//           userModel.userId, addressId, priceDelivery, totalPrice.toString());
//     } else {
//       emit(const OrderFailure(errorMessage: "the internet is slow, try again"));
//     }
//   }
}
