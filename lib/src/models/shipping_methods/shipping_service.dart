class ShippingService {
  String name;
  var rate;
  String currencyCode;
  String shippingMethod;

  ShippingService({this.name, this.rate, this.currencyCode, this.shippingMethod});

  ShippingService.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rate = json['rate'];
    currencyCode = json['currencyCode'];
    shippingMethod = json['shipping_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['rate'] = this.rate;
    data['currencyCode'] = this.currencyCode;
    data['shipping_method'] = this.shippingMethod;
    return data;
  }
}
