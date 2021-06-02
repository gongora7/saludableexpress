import 'package:flutter_app1/src/models/address/country.dart';

class CountriesResponse {
  String success;
  List<Country> data;
  String message;

  CountriesResponse({this.success, this.data, this.message});

  CountriesResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<Country>();
      json['data'].forEach((v) {
        data.add(new Country.fromJson(v));
      });
    }
    message = json['message'];
  }

  CountriesResponse.withError(String error) {
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
