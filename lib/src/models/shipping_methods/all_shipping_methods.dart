import 'package:flutter_app1/src/models/shipping_methods/shipping_method.dart';

class AllShippingMethods {
  ShippingMethod freeShipping;
  ShippingMethod localPickup;
  ShippingMethod flateRate;
  ShippingMethod shippingPrice;

  AllShippingMethods(
      {this.freeShipping,
      this.localPickup,
      this.flateRate,
      this.shippingPrice});

  AllShippingMethods.fromJson(Map<String, dynamic> json) {
    freeShipping = json['freeShipping'] != null
        ? new ShippingMethod.fromJson(json['freeShipping'])
        : null;
    localPickup = json['localPickup'] != null
        ? new ShippingMethod.fromJson(json['localPickup'])
        : null;
    flateRate = json['flateRate'] != null
        ? new ShippingMethod.fromJson(json['flateRate'])
        : null;
    shippingPrice = json['shippingprice'] != null
        ? new ShippingMethod.fromJson(json['shippingprice'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.freeShipping != null) {
      data['freeShipping'] = this.freeShipping.toJson();
    }
    if (this.localPickup != null) {
      data['localPickup'] = this.localPickup.toJson();
    }
    if (this.flateRate != null) {
      data['flateRate'] = this.flateRate.toJson();
    }
    if (this.shippingPrice != null) {
      data['shippingprice'] = this.shippingPrice.toJson();
    }
    return data;
  }
}
