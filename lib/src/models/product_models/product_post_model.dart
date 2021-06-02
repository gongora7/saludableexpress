import 'package:flutter_app1/src/models/product_models/product_post_filter.dart';

import 'product_post_price.dart';

class ProductPostModel {
  String categoriesId;
  String currencyCode;
  String customersId;
  int productsId;
  List<ProductPostFilter> filters;
  int languageId;
  int pageNumber;
  ProductPostPrice price;
  String type;

  ProductPostModel(
      {this.categoriesId,
      this.currencyCode,
      this.customersId,
      this.productsId,
      this.filters,
      this.languageId,
      this.pageNumber,
      this.price,
      this.type});

  ProductPostModel.fromJson(Map<String, dynamic> json) {
    categoriesId = json['categories_id'];
    currencyCode = json['currency_code'];
    customersId = json['customers_id'];
    productsId = json['products_id'];
    if (json['filters'] != null) {
      filters = new List<ProductPostFilter>();
      json['filters'].forEach((v) {
        filters.add(new ProductPostFilter.fromJson(v));
      });
    }
    languageId = json['language_id'];
    pageNumber = json['page_number'];
    price = json['price'] != null
        ? new ProductPostPrice.fromJson(json['price'])
        : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categories_id'] = this.categoriesId;
    data['currency_code'] = this.currencyCode;
    data['customers_id'] = this.customersId;
    data['products_id'] = this.productsId;
    if (this.filters != null) {
      data['filters'] = this.filters.map((v) => v.toJson()).toList();
    }
    data['language_id'] = this.languageId;
    data['page_number'] = this.pageNumber;
    if (this.price != null) {
      data['price'] = this.price.toJson();
    }
    data['type'] = this.type;
    return data;
  }
}
