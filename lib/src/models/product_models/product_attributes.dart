import 'product_attribute_option.dart';
import 'product_attribute_value.dart';

class ProductAttribute {
  ProductAttributeOption option;
  List<ProductAttributeValue> values;

  ProductAttribute({this.option, this.values});

  ProductAttribute.fromJson(Map<String, dynamic> json) {
    option = json['option'] != null
        ? new ProductAttributeOption.fromJson(json['option'])
        : null;
    if (json['values'] != null) {
      values = new List<ProductAttributeValue>();
      json['values'].forEach((v) {
        values.add(new ProductAttributeValue.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.option != null) {
      data['option'] = this.option.toJson();
    }
    if (this.values != null) {
      data['values'] = this.values.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
