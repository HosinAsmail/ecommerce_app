import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:test/core/functions/check_internet_function.dart';
import 'package:test/core/services/storage%20services/store_all_data.dart';

import '../../core/api/crud.dart';
import '../../core/functions/handling_failure_response.dart';
import '../../data/data source/remote/favorite/favorite_remote.dart';
import '../../data/model/products model/product_model.dart';
import '../../data/model/user model/user_model.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  Crud crud = Crud();
  UserModel userModel = UserModel.instance;
  StoreAllData storeAllData = StoreAllData();
  List<ProductModel> favoriteProducts = [];
  void addFavorite(ProductModel productModel) async {
    emit(AddFavoriteLoading());
    if (await checkInternetFunction()) {
      try {
        addFavoriteLocally(productModel);
        emit(AddFavoriteSuccess());
        FavoriteRemote favoriteRemote = FavoriteRemote(crud);
        var response = await favoriteRemote.addFavorite(
            productModel.productsId!, userModel.userId);

        String? failureMessage = handlingFailureMessage(response, "no data");
        if (failureMessage != null) {
          emit(AddFavoriteFailure(errorMessage: failureMessage));
          deleteFavoriteLocally(productModel);
        }
      } on Exception catch (e) {
        deleteFavoriteLocally(productModel);

        if (e is ClientException) {
          emit(const AddFavoriteFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(AddFavoriteFailure(
            errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      emit(const AddFavoriteFailure(
          errorMessage:
              "your offline, please turn on the internet and try again"));
    }
  }

  Future<void> deleteFavorite(ProductModel productModel) async {
    emit(DeleteFavoriteLoading());
    if (await checkInternetFunction()) {
      try {
        deleteFavoriteLocally(productModel);
        emit(DeleteFavoriteSuccess());
        FavoriteRemote favoriteRemote = FavoriteRemote(crud);
        var response = await favoriteRemote.deleteFavorite(
            productModel.productsId!, userModel.userId);

        String? failureMessage = handlingFailureMessage(response, "no data");
        if (failureMessage != null) {
          emit(DeleteFavoriteFailure(errorMessage: failureMessage));
          addFavoriteLocally(productModel);
          // // we emit the success state here to rebuild the UI
          // emit(GetFavoriteSuccess());// warning!!
        }
      } on Exception catch (e) {
        addFavoriteLocally(productModel);
        if (e is ClientException) {
          emit(const DeleteFavoriteFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(DeleteFavoriteFailure(
            errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      print('=============================');
      emit(const DeleteFavoriteFailure(
          errorMessage:
              "your offline, please turn on the internet and try again"));
    }
  }

  void getFavorite() async {
    emit(GetFavoriteLoading());
    if (favoriteProducts.isEmpty) {
      List<Map<String, dynamic>> favorites =
          await storeAllData.readData('products', where: "favorite='1'");
      if (favorites.isNotEmpty) {
        for (final favorite in favorites) {
          favoriteProducts.add(ProductModel.fromJson(favorite));
        }
        emit(GetFavoriteSuccess());
      } else {
        getAsyncFavorite();
      }
    } else {
      emit(GetFavoriteSuccess());
    }
  }

  void getAsyncFavorite() async {
    emit(GetFavoriteLoading());
    if (await checkInternetFunction()) {
      try {
        favoriteProducts.clear();
        await storeAllData.updateData('products', {'favorite': '0'},
            where: "favorite='1'");
        FavoriteRemote favoriteRemote = FavoriteRemote(crud);
        var response = await favoriteRemote.getFavorite(userModel.userId);
        if (response is Map<String, dynamic>) {
          for (final product in response['products']) {
            favoriteProducts.add(ProductModel.fromJson(product));
            storeAllData.updateData('products', {'favorite': '1'},
                where: "products_id='${product['products_id']}'");
          }
        }
        String? failureMessage = handlingFailureMessage(response, "no data");
        if (failureMessage != null) {
          emit(GetFavoriteFailure(errorMessage: failureMessage));
        } else {
          emit(GetFavoriteSuccess());
        }
      } on Exception catch (e) {
        if (e is ClientException) {
          emit(const GetFavoriteFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(GetFavoriteFailure(
            errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      emit(const GetFavoriteFailure(
          errorMessage:
              "your offline, please turn on the internet and try again"));
    }
  }

  void addFavoriteLocally(ProductModel productModel) {
    productModel.favorite = '1';
    favoriteProducts.add(productModel);
    storeAllData.updateData('products', {'favorite': '1'},
        where: "products_id='${productModel.productsId}'");
  }

  void deleteFavoriteLocally(ProductModel productModel) {
    productModel.favorite = '0';
    favoriteProducts.remove(productModel);
    storeAllData.updateData('products', {'favorite': '0'},
        where: "products_id='${productModel.productsId}'");
  }
}
