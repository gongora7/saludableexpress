import 'package:flutter_app1/src/models/address/my_address.dart';

class AddressResponse {
  String success;
  List<MyAddress> data;
  String message;

  AddressResponse({this.success, this.data, this.message});

  AddressResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<MyAddress>();
      json['data'].forEach((v) {
        data.add(new MyAddress.fromJson(v));
      });
    }
    message = json['message'];
  }

  AddressResponse.withError(String error) {
    success = "1";
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