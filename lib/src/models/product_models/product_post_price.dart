class ProductPostPrice {
  var maxPrice;
  var minPrice;

  ProductPostPrice({this.maxPrice, this.minPrice});

  ProductPostPrice.fromJson(Map<String, dynamic> json) {
    maxPrice = json['maxPrice'];
    minPrice = json['minPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maxPrice'] = this.maxPrice;
    data['minPrice'] = this.minPrice;
    return data;
  }
}