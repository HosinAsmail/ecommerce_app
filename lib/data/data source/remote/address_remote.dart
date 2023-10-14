import 'package:test/core/api/crud.dart';
import 'package:test/core/constant/app_links.dart';

class AddressRemote {
  Crud crud;
  AddressRemote(this.crud);
  getAddress(String usersId) async {
    var response =
        await crud.postData(AppLinks.viewAddressLink, {"users_id": usersId});
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }

  deleteAddress(String addressId) async {
    var response = await crud
        .postData(AppLinks.deleteAddressLink, {"address_id": addressId});
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }
}
