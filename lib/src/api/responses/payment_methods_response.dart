import 'package:flutter_app1/src/models/payment_methods/payment_method.dart';

class PaymentMethodsResponse {
  String success;
  List<PaymentMethodObj> data;
  String message;

  PaymentMethodsResponse({this.success, this.data, this.message});

  PaymentMethodsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<PaymentMethodObj>();
      json['data'].forEach((v) {
        data.add(new PaymentMethodObj.fromJson(v));
      });
    }
    message = json['message'];
  }

  PaymentMethodsResponse.withError(String error) {
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