class OrderAttribute {
  int ordersProductsAttributesId;
  int ordersId;
  int ordersProductsId;
  int productsId;
  String productsOptions;
  String productsOptionsValues;
  String optionsValuesPrice;
  String pricePrefix;

  OrderAttribute(
      {this.ordersProductsAttributesId,
        this.ordersId,
        this.ordersProductsId,
        this.productsId,
        this.productsOptions,
        this.productsOptionsValues,
        this.optionsValuesPrice,
        this.pricePrefix});

  OrderAttribute.fromJson(Map<String, dynamic> json) {
    ordersProductsAttributesId = json['orders_products_attributes_id'];
    ordersId = json['orders_id'];
    ordersProductsId = json['orders_products_id'];
    productsId = json['products_id'];
    productsOptions = json['products_options'];
    productsOptionsValues = json['products_options_values'];
    optionsValuesPrice = json['options_values_price'];
    pricePrefix = json['price_prefix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orders_products_attributes_id'] = this.ordersProductsAttributesId;
    data['orders_id'] = this.ordersId;
    data['orders_products_id'] = this.ordersProductsId;
    data['products_id'] = this.productsId;
    data['products_options'] = this.productsOptions;
    data['products_options_values'] = this.productsOptionsValues;
    data['options_values_price'] = this.optionsValuesPrice;
    data['price_prefix'] = this.pricePrefix;
    return data;
  }
}