import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:test/core/api/crud.dart';
import 'package:test/core/functions/check_internet_function.dart';
import 'package:test/core/services/storage%20services/store_all_data.dart';
import 'package:test/data/data%20source/remote/product_remote.dart';
import 'package:test/data/model/products%20model/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:test/data/model/user%20model/user_model.dart';

import '../../core/functions/handling_failure_response.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  int? selected;
  Crud crud = Crud();
  String? categoryId;
  UserModel userModel = UserModel.instance;
  Map<String, List<ProductModel>> categoryProducts = {};
  List<ProductModel> offers = [];
  StoreAllData storeAllData = StoreAllData();
  ScrollController gridControl = ScrollController();
  int requestNumber = 0;
  void getProduct(
    int currentSelected,
    String categoriesId,
  ) async {
    // removingGridListener();
    //WARNING: be careful here
    emit(ProductLoading(isFirstGetData: isFirst));
    selected = currentSelected;
    categoryId = categoriesId;
    if (isFirst) {
      requestNumber = 0;
      addingGridListener();
    }
    if(isFirst==true){
      
    }
    try {
      if (!categoryProducts.containsKey(categoriesId)) {
        List<Map<String, dynamic>> data =
            await storeAllData.selectProductByCategory(categoriesId);
        if (data.isNotEmpty) {
          List<ProductModel> products = [];
          for (final product in data) {
            products.add(ProductModel.fromJson(product));
          }
          categoryProducts[categoriesId] = products;
          print("the data has been got from the locale database");
          emit(ProductSuccess());
        } else {
          getAsyncProduct();
        }
      } else {
        // addingGridListener();
        emit(ProductSuccess());
      }
    } on Exception catch (e) {
      emit(ProductFailure(errorMessage: "unknown problem : ${e.toString()} "));
    }
  }

  void getAsyncProduct() async {
    emit(ProductLoading(isFirstGetData: isFirst));
    if (await checkInternetFunction()) {
      try {
        if (isFirst) {
          requestNumber = 0;
          // ignore: invalid_use_of_protected_member
          // remove the previous one if existed and add another
          addingGridListener();
        }
        ProductRemote productRemote = ProductRemote(crud);
        var response = await productRemote.getProductsByCategory(
            categoryId!, userModel.userId, requestNumber.toString());
        if (response is Map<String, dynamic>) {
          List<ProductModel> products = [];
          // storeAllData.deleteData('products',
          // where: "categories_id='$categoryId'");
          for (final product in response['data']) {
            products.add(ProductModel.fromJson(product));
            // storeAllData.insertData('products', product);
          }
          requestNumber++;
          categoryProducts[categoryId!] == null
              ? categoryProducts[categoryId!] = products
              : categoryProducts[categoryId!]!.addAll(products);
        }

        String? failureMessage =
            handlingFailureMessage(response, "no more products to show");
        if (failureMessage != null) {
          emit(ProductFailure(errorMessage: failureMessage));
        } else {
          emit(ProductSuccess());
        }
      } on Exception catch (e) {
        if (e is ClientException) {
          emit(const ProductFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(
            ProductFailure(errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      emit(const ProductFailure(
          errorMessage:
              "your offline, please turn on the internet and try again"));
    }
  }

  void getOffers({bool isFirst = false}) async {
    emit(ProductLoading(isFirstGetData: isFirst));
    try {
      if (offers.isEmpty) {
        // List<Map<String, dynamic>> data =
        //     await storeAllData.selectProductByCategory(categoriesId);
        // if (data.isNotEmpty) {
        //   for (final product in data) {
        //     offers.add(ProductModel.fromJson(product));
        //   }
        //   print("the data has been got from the locale database");
        //   emit(ProductSuccess());
        // } else {
        getAsyncOffers(isFirst: isFirst);
        // }
      } else {
        emit(ProductSuccess());
      }
    } on Exception catch (e) {
      emit(ProductFailure(errorMessage: "unknown problem : ${e.toString()} "));
    }
  }

  void getAsyncOffers({bool isFirst = false}) async {
    emit(ProductLoading(isFirstGetData: isFirst));
    if (await checkInternetFunction()) {
      try {
        ProductRemote productRemote = ProductRemote(crud);
        var response = await productRemote.getOffers(userModel.userId);
        if (response is Map<String, dynamic>) {
          // storeAllData.deleteData('products',
          // where: "categories_id='$categoryId'");
          for (final product in response['data']) {
            offers.add(ProductModel.fromJson(product));
            // storeAllData.insertData('products', product);
          }
        }

        String? failureMessage = handlingFailureMessage(response, "no data");
        if (failureMessage != null) {
          emit(ProductFailure(errorMessage: failureMessage));
        } else {
          emit(ProductSuccess());
        }
      } on Exception catch (e) {
        if (e is ClientException) {
          emit(const ProductFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(
            ProductFailure(errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      emit(const ProductFailure(
          errorMessage:
              "your offline, please turn on the internet and try again"));
    }
  }

  void addingGridListener() async {
    // ignore: invalid_use_of_protected_member
    if (!gridControl.hasListeners) {
      print('=====================================adding the grid listener');
      await Future.delayed(const Duration(seconds: 1));
      gridControl.addListener(onGridScroll);
    } else {
      print(
          "==================================the listener is already existed");
    }
  }

  void removingGridListener() {
    print('=====================================removing the grid listener');
    gridControl.removeListener(onGridScroll);
  }

  void disposeGridControl() {
    gridControl.dispose();
  }

  void onGridScroll() {
    print("=======================I am listening ");
    if (gridControl.position.maxScrollExtent == gridControl.offset) {
      getAsyncProduct();
    }
  }

  bool get isFirst {
    if (categoryProducts.containsKey(categoryId)) {
      return false;
    } else {
      return true;
    }
  }
}
