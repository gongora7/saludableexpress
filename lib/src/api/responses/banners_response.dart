import 'package:flutter_app1/src/models/banner_models/banner.dart';

class BannersResponse {
  String success;
  List<Banner> bannersData;
  String message;

  BannersResponse({this.success, this.bannersData, this.message});

  BannersResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      bannersData = new List<Banner>();
      json['data'].forEach((v) {
        bannersData.add(new Banner.fromJson(v));
      });
    }
    message = json['message'];
  }

  BannersResponse.withError(String error) {
    success = "0";
    bannersData = null;
    message = error;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.bannersData != null) {
      data['data'] = this.bannersData.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}
