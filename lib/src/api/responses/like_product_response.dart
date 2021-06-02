import 'package:flutter_app1/src/models/like_product_data.dart';

class LikeProductResponse {
  String success;
  List<LikeProductData> productData;
  String message;

  LikeProductResponse({this.success, this.productData, this.message});

  LikeProductResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['product_data'] != null) {
      productData = new List<LikeProductData>();
      json['product_data'].forEach((v) {
        productData.add(new LikeProductData.fromJson(v));
      });
    }
    message = json['message'];
  }

  LikeProductResponse.withError(String error) {
    success = "0";
    productData = null;
    message = error;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.productData != null) {
      data['product_data'] = this.productData.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}
