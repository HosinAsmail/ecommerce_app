import 'package:test/core/api/crud.dart';
import 'package:test/core/constant/app_links.dart';

class VerifyCodeRemote {
  Crud crud;
  VerifyCodeRemote(this.crud);
  postData(String code, String email, String isSignUp) async {
    var response = await crud.postData(AppLinks.verifyCodeLink,
        {"email": email, "verifyCode": code, "isSignUp": isSignUp});
    return response.fold((l) => l, (r) => r);
  }
}
