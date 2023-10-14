import 'package:test/core/api/crud.dart';
import 'package:test/core/constant/app_links.dart';

class FavoriteRemote {
  Crud crud;
  FavoriteRemote(this.crud);
  addFavorite(String productsId, String usersId) async {
    var response = await crud.postData(AppLinks.addFavoriteLink,
        {"products_id": productsId, "users_id": usersId});
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }

  deleteFavorite(String productsId, String usersId) async {
    var response = await crud.postData(AppLinks.deleteFavoriteLink,
        {"products_id": productsId, "users_id": usersId});
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }

  getFavorite(String usersId) async {
    var response =
        await crud.postData(AppLinks.viewFavoriteLink, {"users_id": usersId});
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }
}
