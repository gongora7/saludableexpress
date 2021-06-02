class GetRatesPostProduct {
  int productId;
  int customerBasketQuantity;
  var finalPrice;
  var price;
  var total;
  String unit;
  String weight;

  GetRatesPostProduct(
      {this.productId,
      this.customerBasketQuantity,
      this.finalPrice,
      this.price,
      this.total,
      this.unit,
      this.weight});

  GetRatesPostProduct.fromJson(Map<String, dynamic> json) {
    productId = json['products_id'];
    customerBasketQuantity = json['customers_basket_quantity'];
    finalPrice = json['final_price'];
    price = json['price'];
    total = json['total'];
    unit = json['unit'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['products_id'] = this.productId;
    data['customers_basket_quantity'] = this.customerBasketQuantity;
    data['final_price'] = this.finalPrice;
    data['price'] = this.price;
    data['total'] = this.total;
    data['unit'] = this.unit;
    data['weight'] = this.weight;
    return data;
  }
}
