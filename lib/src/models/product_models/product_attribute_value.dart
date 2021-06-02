class ProductAttributeValue {
  int productsAttributesId;
  int id;
  String value;
  var price;
  String pricePrefix;

  ProductAttributeValue(
      {this.productsAttributesId,
        this.id,
        this.value,
        this.price,
        this.pricePrefix});

  ProductAttributeValue.fromJson(Map<String, dynamic> json) {
    productsAttributesId = json['products_attributes_id'];
    id = json['id'];
    value = json['value'];
    price = json['price'];
    pricePrefix = json['price_prefix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['products_attributes_id'] = this.productsAttributesId;
    data['id'] = this.id;
    data['value'] = this.value;
    data['price'] = this.price;
    data['price_prefix'] = this.pricePrefix;
    return data;
  }
}
