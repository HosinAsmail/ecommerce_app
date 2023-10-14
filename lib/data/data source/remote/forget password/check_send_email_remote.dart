import 'package:test/core/constant/app_links.dart';

import '../../../../core/api/crud.dart';

class CheckSendEmailRemote {
  Crud crud;
  CheckSendEmailRemote(this.crud);
  postData(String email) async {
    var response =
        await crud.postData(AppLinks.checkSendEmailLink, {"email": email});
    return response.fold((l) => l, (r) => r);
  }
}
