import 'package:test/core/api/crud.dart';
import 'package:test/core/constant/app_links.dart';

class NotificationRemote {
  Crud crud;
  NotificationRemote(this.crud);
  getNotifications(String usersId) async {
    var response = await crud.postData(AppLinks.notificationLink,{
      "users_id":usersId
    });
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }
}
