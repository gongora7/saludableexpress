import 'package:flutter_app1/src/models/product_models/product.dart';

class ProductsResponse {
  String success;
  List<Product> productData;
  String message;
  int totalRecord;

  ProductsResponse(
      {this.success, this.productData, this.message, this.totalRecord});

  ProductsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['product_data'] != null) {
      productData = new List<Product>();
      json['product_data'].forEach((v) {
        productData.add(new Product.fromJson(v));
      });
    }
    message = json['message'];
    totalRecord = json['total_record'];
  }

  ProductsResponse.withError(String error) {
    success = "0";
    productData = null;
    message = error;
    totalRecord = 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.productData != null) {
      data['product_data'] = this.productData.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['total_record'] = this.totalRecord;
    return data;
  }
}
