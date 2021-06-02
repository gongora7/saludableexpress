import 'package:flutter_app1/src/models/categories_response/category.dart';

class CategoriesResponse {
  String success;
  List<Category> categoriesData;
  String message;
  int categories;

  CategoriesResponse(
      {this.success, this.categoriesData, this.message, this.categories});

  CategoriesResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      categoriesData = new List<Category>();
      json['data'].forEach((v) {
        categoriesData.add(new Category.fromJson(v));
      });
    }
    message = json['message'];
    categories = json['categories'];
  }

  CategoriesResponse.withError(String error) {
    success = "0";
    categoriesData = null;
    message = error;
    categories = null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.categoriesData != null) {
      data['data'] = this.categoriesData.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['categories'] = this.categories;
    return data;
  }
}
