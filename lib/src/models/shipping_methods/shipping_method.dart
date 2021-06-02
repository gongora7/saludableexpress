import 'shipping_service.dart';

class ShippingMethod {
  String success;
  String message;
  String name;
  List<ShippingService> services;

  ShippingMethod({this.success, this.message, this.name, this.services});

  ShippingMethod.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    name = json['name'];
    if (json['services'] != null) {
      services = new List<ShippingService>();
      json['services'].forEach((v) {
        services.add(new ShippingService.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['name'] = this.name;
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
