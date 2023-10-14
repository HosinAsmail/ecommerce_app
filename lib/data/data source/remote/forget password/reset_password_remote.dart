import 'package:test/core/api/crud.dart';
import 'package:test/core/constant/app_links.dart';

class ResetPasswordRemote {
  Crud crud;
  ResetPasswordRemote(this.crud);
  postData(String email, String password) async {
    var response = await crud.postData(
        AppLinks.resetPasswordLink, {"email": email, "password": password});
    return response.fold((l) => l, (r) => r);
  }
}
