import 'package:bloc/bloc.dart';
import 'package:test/core/api/crud.dart';
import 'package:test/core/functions/check_internet_function.dart';
import 'package:test/core/services/storage%20services/store_all_data.dart';
import 'package:test/data/data%20source/remote/home_remote.dart';
import 'package:test/data/model/ad_model.dart';
import 'package:test/data/model/categories%20model/categories_model.dart';
import 'package:test/data/model/products%20model/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

import '../../core/functions/handling_failure_response.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  Crud crud = Crud();
  List<CategoriesModel> categories = [];
  List<ProductModel> offeredProducts = [];
  List<ProductModel> topSelling = [];
  List<AdModel> ads = [];
  StoreAllData storeAllData = StoreAllData();
  Future<void> getData() async {
    try {
      emit(HomeLoading());
      if (categories.isEmpty) {
        List<Map<String, dynamic>> list =
            await storeAllData.readData('categories');
        if (list.isEmpty) {
          getAsyncData();
        } else {
          for (final category in list) {
            categories.add(CategoriesModel.fromJson(category));
          }
          emit(HomeSuccess());
        }
      } else {
        emit(HomeSuccess());
      }
    } on Exception catch (e) {
      print(e);
      emit(HomeFailure(errorMessage: "unknown problem : ${e.toString()} "));
    }
  }

  Future<void> getAsyncData() async {
    emit(HomeLoading());
    if (await checkInternetFunction()) {
      print('we get data from the internet now=================');
      try {
        HomeRemote homeRemote = HomeRemote(crud);
        var response = await homeRemote.getData();
        if (response is Map<String, dynamic>) {
          categories.clear();
          await storeAllData.deleteData('categories');
          offeredProducts.clear();
          topSelling.clear();
          ads.clear();
          for (final category in response['categories']) {
            categories.add(CategoriesModel.fromJson(category));
            await storeAllData.insertData('categories', category);
          }
          for (final product in response['offers']) {
            offeredProducts.add(ProductModel.fromJson(product));
          }
          for (final product in response['topSelling']) {
            topSelling.add(ProductModel.fromJson(product));
          }
          for (final ad in response['ads']) {
            ads.add(AdModel.fromJson(ad));
          }
        }
        String? failureMessage =
            handlingFailureMessage(response, "no data found");

        if (failureMessage != null) {
          emit(HomeFailure(errorMessage: failureMessage));
        } else {
          emit(HomeSuccess());
        }
      } on Exception catch (e) {
        print(e);
        if (e is ClientException) {
          emit(const HomeFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(HomeFailure(errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      emit(const HomeFailure(errorMessage: "the internet is slow, try again"));
    }
  }
}
