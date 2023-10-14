import 'package:test/core/api/crud.dart';
import 'package:test/core/constant/app_links.dart';

class CartRemote {
  Crud crud;
  CartRemote(this.crud);
  addCart(String productsId, String usersId, String productsCount,
      String totalProductPrice) async {
    var response = await crud.postData(AppLinks.addCartLink, {
      "products_id": productsId,
      "users_id": usersId,
      "products_count": productsCount,
      "total_product_price": totalProductPrice
    });
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }

  deleteCart(String productsId, String usersId) async {
    var response = await crud.postData(AppLinks.deleteCartLink,
        {"products_id": productsId, "users_id": usersId});
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }

  getCart(String usersId) async {
    var response =
        await crud.postData(AppLinks.viewCartLink, {"users_id": usersId});
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }
}
