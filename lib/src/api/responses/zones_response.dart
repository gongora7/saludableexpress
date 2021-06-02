import 'package:flutter_app1/src/models/address/zone.dart';

class ZonesResponse {
  String success;
  List<Zone> data;
  String message;

  ZonesResponse({this.success, this.data, this.message});

  ZonesResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<Zone>();
      json['data'].forEach((v) {
        data.add(new Zone.fromJson(v));
      });
    }
    message = json['message'];
  }

  ZonesResponse.withError(String error) {
    success = "0";
    data = null;
    message = error;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}