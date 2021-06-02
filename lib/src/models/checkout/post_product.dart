import 'package:flutter_app1/src/models/checkout/post_product_attribute.dart';
import 'package:flutter_app1/src/models/product_models/product_category.dart';

class PostProduct {
  String products_id;
  String products_name;
  String model;
  var price;
  var final_price;
  String weight;
  bool on_sale;
  String unit;
  String image;
  String manufacture;
  List<ProductCategory> categories;
  var subtotal;
  var total;
  String customers_basket_quantity;
  List<PostProductAttribute> attributes;

  PostProduct(
      {this.products_id,
      this.products_name,
      this.model,
      this.price,
      this.final_price,
      this.weight,
      this.on_sale,
      this.unit,
      this.image,
      this.manufacture,
      this.categories,
      this.subtotal,
      this.total,
      this.customers_basket_quantity,
      this.attributes});

  PostProduct.fromJson(Map<String, dynamic> json) {
    products_id = json['products_id'];
    products_name = json['products_name'];
    model = json['model'];
    price = json['price'];
    final_price = json['final_price'];
    weight = json['weight'];
    on_sale = json['on_sale'];
    unit = json['unit'];
    image = json['image'];
    manufacture = json['manufacture'];
    if (json['categories'] != null) {
      categories = new List<ProductCategory>();
      json['categories'].forEach((v) {
        categories.add(ProductCategory.fromJson(v));
      });
    }
    subtotal = json['subtotal'];
    total = json['total'];
    customers_basket_quantity = json['customers_basket_quantity'];
    if (json['attributes'] != null) {
      attributes = new List<PostProductAttribute>();
      json['attributes'].forEach((v) {
        attributes.add(PostProductAttribute.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['products_id'] = this.products_id;
    data['products_name'] = this.products_name;
    data['model'] = this.model;
    data['price'] = this.price;
    data['final_price'] = this.final_price;
    data['weight'] = this.weight;
    data['on_sale'] = this.on_sale;
    data['unit'] = this.unit;
    data['image'] = this.image;
    data['manufacture'] = this.manufacture;
    if (this.categories != null) {
      data['categories'] = this.categories.map((e) => e.toJson()).toList();
    }
    data['subtotal'] = this.subtotal;
    data['total'] = this.total;
    data['customers_basket_quantity'] = this.customers_basket_quantity;
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((e) => e.toJson()).toList();
    }
    return data;
  }
}
