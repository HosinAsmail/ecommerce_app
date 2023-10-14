import 'package:test/core/api/crud.dart';
import 'package:test/core/constant/app_links.dart';

class SignUpRemote {
  Crud crud;
  SignUpRemote(this.crud);
  postData(String username, String password, String email, String phone) async {
    var response = await crud.postData(AppLinks.signUpLink, {
      "username": username,
      "password": password,
      "email": email,
      "phone": phone,
    });
    return response.fold((l) => l, (r) => r);
  }
}
