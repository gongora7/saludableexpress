import 'package:flutter_app1/src/models/filters_models/filters.dart';

class FiltersResponse {
  String success;
  List<Filters> filters;
  String message;
  var maxPrice;

  FiltersResponse({this.success, this.filters, this.message, this.maxPrice});

  FiltersResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['filters'] != null) {
      filters = new List<Filters>();
      json['filters'].forEach((v) {
        filters.add(new Filters.fromJson(v));
      });
    }
    message = json['message'];
    maxPrice = json['maxPrice'];
  }

  FiltersResponse.withError(String error) {
    success = "0";
    filters = [];
    message = error;
    maxPrice = "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.filters != null) {
      data['filters'] = this.filters.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['maxPrice'] = this.maxPrice;
    return data;
  }
}
