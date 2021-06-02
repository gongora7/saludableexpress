import 'all_shipping_methods.dart';

class RatesData {
  String tax;
  AllShippingMethods shippingMethods;

  RatesData({this.tax, this.shippingMethods});

  RatesData.fromJson(Map<String, dynamic> json) {
    tax = json['tax'];
    shippingMethods = json['shippingMethods'] != null
        ? new AllShippingMethods.fromJson(json['shippingMethods'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tax'] = this.tax;
    if (this.shippingMethods != null) {
      data['shippingMethods'] = this.shippingMethods.toJson();
    }
    return data;
  }
}
