import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:test/core/api/crud.dart';
import 'package:test/core/functions/handling_failure_response.dart';
import 'package:test/data/model/products%20model/product_model.dart';

import '../../core/functions/check_internet_function.dart';
import '../../data/data source/remote/product_remote.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  List<ProductModel> searchedProducts = [];
  Crud crud = Crud();
  bool isStartSearching = false;

  void search(String search) async {
    emit(SearchLoading());
    if (await checkInternetFunction()) {
      try {
        searchedProducts.clear();
        ProductRemote productRemote = ProductRemote(crud);
        var response = await productRemote.searchData(search,'40'/*userModel.usersId*/);
        if (response is Map<String, dynamic>) {
          for (final product in response['data']) {
            searchedProducts.add(ProductModel.fromJson(product));
          }
        }
        String? failureMessage = handlingFailureMessage(response,
            "there is no product of the name $search try correcting the name and try again");
        if (failureMessage != null) {
          emit(SearchFailure(errorMessage: failureMessage));
        } else {
          emit(SearchSuccess());
        }
      } on Exception catch (e) {
        if (e is ClientException) {
          emit(const SearchFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(SearchFailure(errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      emit(const SearchFailure(
          errorMessage:
              "your offline, please turn on the internet and try again"));
    }
  }

  void checkSearch(String text) {
    print('checking...');
    if (text.isEmpty || text == '') {
      isStartSearching = false;
      emit(SearchInitial());
    } else {
      isStartSearching = true;
      emit(StartSearching());
    }
  }
}
