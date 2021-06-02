import 'package:flutter_app1/src/models/orders/order_category.dart';

import 'order_attribute.dart';

class OrderProduct {
  int ordersProductsId;
  int ordersId;
  int productsId;
  Null productsModel;
  String productsName;
  var productsPrice;
  var finalPrice;
  String productsTax;
  int productsQuantity;
  String image;
  List<OrderCategory> categories;
  List<OrderAttribute> attributes;

  OrderProduct(
      {this.ordersProductsId,
        this.ordersId,
        this.productsId,
        this.productsModel,
        this.productsName,
        this.productsPrice,
        this.finalPrice,
        this.productsTax,
        this.productsQuantity,
        this.image,
        this.categories,
        this.attributes});

  OrderProduct.fromJson(Map<String, dynamic> json) {
    ordersProductsId = json['orders_products_id'];
    ordersId = json['orders_id'];
    productsId = json['products_id'];
    productsModel = json['products_model'];
    productsName = json['products_name'];
    productsPrice = json['products_price'];
    finalPrice = json['final_price'];
    productsTax = json['products_tax'];
    productsQuantity = json['products_quantity'];
    image = json['image'];
    if (json['categories'] != null) {
      categories = new List<OrderCategory>();
      json['categories'].forEach((v) {
        categories.add(new OrderCategory.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = new List<OrderAttribute>();
      json['attributes'].forEach((v) {
        attributes.add(new OrderAttribute.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orders_products_id'] = this.ordersProductsId;
    data['orders_id'] = this.ordersId;
    data['products_id'] = this.productsId;
    data['products_model'] = this.productsModel;
    data['products_name'] = this.productsName;
    data['products_price'] = this.productsPrice;
    data['final_price'] = this.finalPrice;
    data['products_tax'] = this.productsTax;
    data['products_quantity'] = this.productsQuantity;
    data['image'] = this.image;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}