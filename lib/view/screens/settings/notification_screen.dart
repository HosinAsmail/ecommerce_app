import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/core/constant/app_color.dart';
import 'package:test/cubits/notification%20cubit/notification_cubit.dart';
import 'package:test/data/model/notification_model.dart';
import 'package:test/view/widget/settings/notification/notification_list_tile.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationCubit notificationCubit = context.read<NotificationCubit>();
    notificationCubit.getData();
    return Scaffold(
      appBar: AppBar(
        title: const Text("الإشعارات"),
        actions: [
          IconButton(
              onPressed: () {
                notificationCubit.getAsyncData();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          notificationCubit.getAsyncData();
        },
        child: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            if (state is NotificationLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NotificationSuccess ||
                state is NotificationFailure) {
              List<NotificationModel> notifications =
                  notificationCubit.notifications;
              if (notifications.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        return NotificationListTile(
                            notificationModel: notifications[index]);
                      }),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      "لا يوجد أي إشعارات",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: AppColor.black),
                    ),
                  ),
                );
              }
            } else {
              return const Text("fail");
            }
          },
        ),
      ),
    );
  }
}
