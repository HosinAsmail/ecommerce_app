import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:test/core/api/crud.dart';
import 'package:test/core/functions/check_internet_function.dart';
import 'package:test/core/functions/handling_failure_response.dart';
import 'package:test/core/services/storage%20services/store_all_data.dart';
import 'package:test/data/data%20source/remote/notification_remote.dart';
import 'package:test/data/model/notification_model.dart';
import 'package:test/data/model/user%20model/user_model.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());
  Crud crud = Crud();
  List<NotificationModel> notifications = [];
  UserModel userModel = UserModel.instance;
  StoreAllData storeAllData = StoreAllData();
  Future<void> getData() async {
    try {
      emit(NotificationLoading());

      if (notifications.isEmpty) {
        List<Map<String, dynamic>> list =
            await storeAllData.readData('notifications');
        print(list);
        if (list.isEmpty) {
          getAsyncData();
        } else {
          for (final category in list) {
            notifications.add(NotificationModel.fromJson(category));
          }
          emit(NotificationSuccess());
        }
      } else {
        emit(NotificationSuccess());
      }
    } on Exception catch (e) {
      print(e);
      emit(NotificationFailure(
          errorMessage: "unknown problem : ${e.toString()} "));
    }
  }

  Future<void> getAsyncData() async {
    emit(NotificationLoading());
    if (await checkInternetFunction()) {
      print('we get data from the internet now=================');
      try {
        NotificationRemote notificationRemote = NotificationRemote(crud);
        var response =
            await notificationRemote.getNotifications(userModel.userId);
        if (response is Map<String, dynamic>) {
          notifications.clear();
          await storeAllData.deleteData('notifications');
          for (final notification in response['data']) {
            notifications.add(NotificationModel.fromJson(notification));
            await storeAllData.insertData('notifications', notification);
          }
        }
        String? failureMessage =
            handlingFailureMessage(response, "no notifications found");

        if (failureMessage != null) {
          emit(NotificationFailure(errorMessage: failureMessage));
        } else {
          emit(NotificationSuccess());
        }
      } on Exception catch (e) {
        print(e);
        if (e is ClientException) {
          emit(const NotificationFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(NotificationFailure(
            errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      emit(const NotificationFailure(
          errorMessage: "the internet is slow, try again"));
    }
  }
}
