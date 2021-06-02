import 'package:flutter_app1/src/models/address/country.dart';
import 'package:flutter_app1/src/models/address/zone.dart';

class Address {
  String deliveryFirstName;
  String deliveryLastName;
  String deliveryCity;
  String deliveryPostCode;
  String deliveryStreetAddress;
  String deliveryCountryCode;
  String deliveryPhone;
  String deliveryLocation;
  String deliveryLat;
  String deliveryLong;
  Country deliveryCountry;
  Zone deliveryZone;


  Address(
      {this.deliveryFirstName,
      this.deliveryLastName,
      this.deliveryCity,
      this.deliveryPostCode,
      this.deliveryStreetAddress,
      this.deliveryCountryCode,
      this.deliveryPhone,
      this.deliveryLocation,
      this.deliveryLat,
      this.deliveryLong,
      this.deliveryCountry,
      this.deliveryZone});

  Address.fromJson(Map<String, dynamic> json) {
    deliveryFirstName = json["delivery_firstname"];
    deliveryLastName = json["delivery_lastname"];
    deliveryCity = json["delivery_city"];
    deliveryPostCode = json["delivery_postcode"];
    deliveryZone = json["delivery_zone"];
    deliveryCountry = json["delivery_country"];
    deliveryStreetAddress = json["delivery_street_address"];
    deliveryCountryCode = json["delivery_country_code"];
    deliveryPhone = json["delivery_phone"];
    deliveryLocation = json["delivery_location"];
    deliveryLat = json["delivery_lat"];
    deliveryLong = json["delivery_long"];
    deliveryCountry = json['delivery_country'] != null ? new Country.fromJson(json['delivery_country']) : null;
    deliveryZone = json['delivery_zone'] != null ? new Zone.fromJson(json['delivery_zone']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['delivery_firstname'] = this.deliveryFirstName;
    data['delivery_lastname'] = this.deliveryLastName;
    data['delivery_city'] = this.deliveryCity;
    data['delivery_postcode'] = this.deliveryPostCode;
    data['delivery_zone'] = this.deliveryZone;
    data['delivery_country'] = this.deliveryCountry;
    data['delivery_street_address'] = this.deliveryStreetAddress;
    data['delivery_country_code'] = this.deliveryCountryCode;
    data['delivery_phone'] = this.deliveryPhone;
    data['delivery_location'] = this.deliveryLocation;
    data['delivery_lat'] = this.deliveryLat;
    data['delivery_long'] = this.deliveryLong;
    if (this.deliveryCountry != null) {
      data['delivery_country'] = this.deliveryCountry.toJson();
    }
    if (this.deliveryZone != null) {
      data['delivery_zone'] = this.deliveryZone.toJson();
    }
    return data;
  }
}
