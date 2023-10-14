class AdModel {
  String? adsId;
  String? adsTitle;
  String? adsTitleAr;
  String? adsBody;
  String? adsBodyAr;
  String? adsDatatime;
  String? adsColor;
  String? adsColorCircle;

  AdModel(
      {this.adsId,
      this.adsTitle,
      this.adsTitleAr,
      this.adsBody,
      this.adsBodyAr,
      this.adsDatatime,
      this.adsColor,
      this.adsColorCircle});

  AdModel.fromJson(Map<String, dynamic> json) {
    adsId = json['ads_id'];
    adsTitle = json['ads_title'];
    adsTitleAr = json['ads_title_ar'];
    adsBody = json['ads_body'];
    adsBodyAr = json['ads_body_ar'];
    adsDatatime = json['ads_datatime'];
    adsColor = json['ads_color'];
    adsColorCircle = json['ads_color_circle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ads_id'] = this.adsId;
    data['ads_title'] = this.adsTitle;
    data['ads_title_ar'] = this.adsTitleAr;
    data['ads_body'] = this.adsBody;
    data['ads_body_ar'] = this.adsBodyAr;
    data['ads_datatime'] = this.adsDatatime;
    data['ads_color'] = this.adsColor;
    data['ads_color_circle'] = this.adsColorCircle;
    return data;
  }
}