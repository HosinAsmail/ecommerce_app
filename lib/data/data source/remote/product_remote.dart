import 'package:test/core/api/crud.dart';
import 'package:test/core/constant/app_links.dart';

class ProductRemote {
  Crud crud;
  ProductRemote(this.crud);
  getProductsByCategory(String categoriesId, String usersId,String requestNumber) async {
    var response = await crud.postData(AppLinks.getProductLink,
        {'categories_id': categoriesId, 'users_id': usersId,"request_number":requestNumber});
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }

  getOffers(String usersId,String requestNumber) async {
    var response =
        await crud.postData(AppLinks.getOffersLink, {'users_id': usersId,"request_number":requestNumber});
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }

  searchData(String search, String usersId) async {
    var response = await crud.postData(
        AppLinks.searchProductLink, {'search': search, 'users_id': usersId});
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }
}
