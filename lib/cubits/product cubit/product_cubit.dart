// ignore_for_file: invalid_use_of_protected_member

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
  Map<String, Map<String, dynamic>> categoryProducts = {};
  List<ProductModel> offers = [];
  int requestOfferNumber = 0;
  bool isOfferOver = false;
  StoreAllData storeAllData = StoreAllData();
  ScrollController gridControl = ScrollController();

  //* products:
  void getProduct(
    int currentSelected,
    String categoriesId,
  ) async {
    selected = currentSelected;
    categoryId = categoriesId;
    emit(ProductLoading(isFirstGetData: isFirst));
    addingGridListener();
    try {
      if (!categoryProducts.containsKey(categoriesId)) {
        List<Map<String, dynamic>> data =
            await storeAllData.selectProductByCategory(categoriesId);
        if (data.isNotEmpty) {
          List<ProductModel> products = [];
          for (final product in data) {
            products.add(ProductModel.fromJson(product));
          }
          categoryProducts[categoriesId] == null
              ? categoryProducts[categoriesId] = {
                  "products": products,
                  "requestNumber": 1
                }
              : categoryProducts[categoriesId] = {
                  "products": products,
                  "requestNumber":
                      categoryProducts[categoriesId]!["requestNumber"]++
                };

          print("the data has been got from the locale database");
          emit(ProductSuccess());
        } else {
          getAsyncProduct();
        }
      } else {
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
        ProductRemote productRemote = ProductRemote(crud);
        var response = await productRemote.getProductsByCategory(
            categoryId!,
            userModel.userId,
            isFirst
                ? "0"
                : categoryProducts[categoryId]!["requestNumber"].toString());
        if (response is Map<String, dynamic>) {
          List<ProductModel> products = [];
          // storeAllData.deleteData('products',
          // where: "categories_id='$categoryId'");
          for (final product in response['data']) {
            products.add(ProductModel.fromJson(product));
            // storeAllData.insertData('products', product);
          }
          if (categoryProducts[categoryId] == null) {
            categoryProducts[categoryId!] = {
              "products": products,
              "requestNumber": 1
            };
          } else {
            categoryProducts[categoryId]!["products"]!.addAll(products);
            categoryProducts[categoryId]!["requestNumber"]++;
          }
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

  void addingGridListener() async {
    removingGridListener();
    await Future.delayed(const Duration(seconds: 1));
    if (categoryProducts[categoryId] == null) {
      print('=====================================adding the grid listener');
      gridControl.addListener(onGridScroll);
    } else if (!categoryProducts[categoryId]!["over"]) {
      print('=====================================adding the grid listener');
      gridControl.addListener(onGridScroll);
    } else {
      return;
    }
  }

  void removingGridListener() {
    if (gridControl.hasListeners) {
      print('=====================================removing the grid listener');
      gridControl.removeListener(onGridScroll);
    } else {
      print("====================================no listeners");
    }
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

  void setCategoryDataCompleted() {
    categoryProducts[categoryId]!["over"] = true;
    removingGridListener();
  }

  void refreshProducts() {
    int requestNumber = categoryProducts[categoryId]!["requestNumber"];
    categoryProducts[categoryId]!["requestNumber"] = 0;
    List<ProductModel> productsTemporary =
        categoryProducts[categoryId]!["products"];
    categoryProducts[categoryId]!["products"].clear();
    try {
      getAsyncProduct();
    } on Exception {
      print(
          "============================================it is working as expected");
      categoryProducts[categoryId]!["requestNumber"] = requestNumber;
      categoryProducts[categoryId]!["products"] = productsTemporary;
    }
  }

  bool isEnoughProducts() {
    if (categoryProducts[categoryId] == null) {
      return false;
    } else if (categoryProducts[categoryId]!["products"].length < 6) {
      return false;
    } else {
      return true;
    }
  }

  bool get isFirst {
    if (categoryProducts[categoryId] == null) {
      return true;
    } else if (categoryProducts[categoryId]!["products"].isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  // * Offers:
  void getOffers() async {
    emit(ProductLoading(isFirstGetData: isFirstOffer));
    addingGridOfferListener();
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
        getAsyncOffers();
        // }
      } else {
        emit(ProductSuccess());
      }
    } on Exception catch (e) {
      emit(ProductFailure(errorMessage: "unknown problem : ${e.toString()} "));
    }
  }

  void getAsyncOffers() async {
    emit(ProductLoading(isFirstGetData: isFirstOffer));
    if (await checkInternetFunction()) {
      try {
        ProductRemote productRemote = ProductRemote(crud);
        var response = await productRemote.getOffers(userModel.userId,
            isFirstOffer ? "0" : requestOfferNumber.toString());
        if (response is Map<String, dynamic>) {
          // storeAllData.deleteData('products',
          // where: "categories_id='$categoryId'");
          for (final product in response['data']) {
            offers.add(ProductModel.fromJson(product));
            // storeAllData.insertData('products', product);
          }
          requestOfferNumber++;
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

  void addingGridOfferListener() async {
    removingGridOfferListener();
    if (!isOfferOver) {
      await Future.delayed(const Duration(seconds: 1));
      print('=====================================adding the grid listener');
      gridControl.addListener(onGridOfferScroll);
    } else {
      print("========================================no way to add a listener");
    }
  }

  void removingGridOfferListener() {
    if (gridControl.hasListeners) {
      print('=====================================removing the grid listener');
      gridControl.removeListener(onGridOfferScroll);
    } else {
      print("====================================no listeners");
    }
  }

  void disposeGridOfferControl() {
    gridControl.dispose();
  }

  bool isEnoughOffers() {
    if (offers.length < 6) {
      return false;
    } else {
      return true;
    }
  }

  void onGridOfferScroll() {
    print("=======================I am listening ");
    if (gridControl.position.maxScrollExtent == gridControl.offset) {
      getAsyncOffers();
    }
  }

  void setOfferCompleted() {
    isOfferOver = true;
    removingGridOfferListener();
  }

  void refreshOffers() {
    int requestNumber = requestOfferNumber;
    requestOfferNumber = 0;
    List<ProductModel> offersTemporary = offers;
    offers.clear();
    try {
      addingGridOfferListener();
      getAsyncOffers();
    } on Exception {
      print(
          "============================================it is working as expected");
      requestOfferNumber = requestNumber;
      categoryProducts[categoryId]!["products"] = offersTemporary;
    }
  }

  bool get isFirstOffer {
    if (offers.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
