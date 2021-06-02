import 'package:flutter_app1/src/models/shipping_methods/rates.dart';

class GetRatesResponse {
  String success;
  RatesData data;
  String message;

  GetRatesResponse({this.success, this.data, this.message});

  GetRatesResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new RatesData.fromJson(json['data']) : null;
    message = json['message'];
  }

  GetRatesResponse.withError(String error) {
    success = "0";
    data = null;
    message = error;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}