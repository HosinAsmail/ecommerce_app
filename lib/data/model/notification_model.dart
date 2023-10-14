class NotificationModel {
  String? notificationId;
  String? notificationTitle;
  String? notificationTitleAr;
  String? notificationBody;
  String? notificationBodyAr;
  String? notificationDatetime;

  NotificationModel(
      {this.notificationId,
      this.notificationTitle,
      this.notificationTitleAr,
      this.notificationBody,
      this.notificationBodyAr,
      this.notificationDatetime});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    notificationId = json['notification_id'];
    notificationTitle = json['notification_title'];
    notificationTitleAr = json['notification_title_ar'];
    notificationBody = json['notification_body'];
    notificationBodyAr = json['notification_body_ar'];
    notificationDatetime = json['notification_datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification_id'] = this.notificationId;
    data['notification_title'] = this.notificationTitle;
    data['notification_title_ar'] = this.notificationTitleAr;
    data['notification_body'] = this.notificationBody;
    data['notification_body_ar'] = this.notificationBodyAr;
    data['notification_datetime'] = this.notificationDatetime;
    return data;
  }
}