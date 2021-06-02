import 'package:flutter_app1/src/models/search_data.dart';

class SearchResponse {
  String success;
  SearchData productData;
  String message;
  int totalRecord;

  SearchResponse(
      {this.success, this.productData, this.message, this.totalRecord});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    productData = json['product_data'] != null
        ? new SearchData.fromJson(json['product_data'])
        : null;
    message = json['message'];
    totalRecord = json['total_record'];
  }

  SearchResponse.withError(String error) {
    success = "1";
    productData = null;
    message = error;
    totalRecord = 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.productData != null) {
      data['product_data'] = this.productData.toJson();
    }
    data['message'] = this.message;
    data['total_record'] = this.totalRecord;
    return data;
  }
}