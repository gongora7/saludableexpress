class PostProductAttribute {
  String attribute_id;
  String orders_id;
  String orders_products_id;
  String products_id;
  String products_options_id;
  String products_options;
  String products_options_values_id;
  String products_options_values;
  var options_values_price;
  String price_prefix;
  String name;

  PostProductAttribute(
      {this.attribute_id,
      this.orders_id,
      this.orders_products_id,
      this.products_id,
      this.products_options_id,
      this.products_options,
      this.products_options_values_id,
      this.products_options_values,
      this.options_values_price,
      this.price_prefix,
      this.name});

  PostProductAttribute.fromJson(Map<String, dynamic> json) {
    attribute_id = json['attribute_id'];
    orders_id = json['orders_id'];
    orders_products_id = json['orders_products_id'];
    products_id = json['products_id'];
    products_options_id = json['products_options_id'];
    products_options = json['products_options'];
    products_options_values_id = json['products_options_values_id'];
    products_options_values = json['products_options_values'];
    options_values_price = json['options_values_price'];
    price_prefix = json['price_prefix'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attribute_id'] = this.attribute_id;
    data['orders_id'] = this.orders_id;
    data['orders_products_id'] = this.orders_products_id;
    data['products_id'] = this.products_id;
    data['products_options_id'] = this.products_options_id;
    data['products_options'] = this.products_options;
    data['products_options_values_id'] = this.products_options_values_id;
    data['products_options_values'] = this.products_options_values;
    data['options_values_price'] = this.options_values_price;
    data['price_prefix'] = this.price_prefix;
    data['name'] = this.name;
    return data;
  }
}
