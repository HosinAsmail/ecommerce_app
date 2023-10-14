import 'package:test/core/api/crud.dart';
import 'package:test/core/constant/app_links.dart';

class HomeRemote {
  Crud crud;
  HomeRemote(this.crud);
  getData() async {
    var response = await crud.getData(AppLinks.homeLink);
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }
}
