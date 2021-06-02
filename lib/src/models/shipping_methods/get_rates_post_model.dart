import 'package:flutter_app1/src/models/shipping_methods/get_rates_post_product.dart';

class GetRatesPost {
  String title;
  String streetAddress;
  String city;
  String state;
  String postcode;
  String zone;
  String taxZoneId;
  String country;
  String countryId;
  String telephone;
  double productsWeight;
  String productsWeightUnit;
  String languageId;
  String currencyCode;
  List<GetRatesPostProduct> products;

  GetRatesPost(
      {this.title,
      this.streetAddress,
      this.city,
      this.state,
      this.postcode,
      this.zone,
      this.taxZoneId,
      this.country,
      this.countryId,
      this.telephone,
      this.productsWeight,
      this.productsWeightUnit,
      this.languageId,
      this.currencyCode,
      this.products});

  GetRatesPost.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    streetAddress = json['street_address'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    zone = json['zone'];
    taxZoneId = json['tax_zone_id'];
    country = json['country'];
    countryId = json['country_id'];
    telephone = json['telephone'];
    productsWeight = json['products_weight'];
    productsWeightUnit = json['products_weight_unit'];
    languageId = json['language_id'];
    currencyCode = json['currency_code'];
    if (json['products'] != null) {
      products = new List<GetRatesPostProduct>();
      json['products'].forEach((v) {
        products.add(new GetRatesPostProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['street_address'] = this.streetAddress;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postcode'] = this.postcode;
    data['zone'] = this.zone;
    data['tax_zone_id'] = this.taxZoneId;
    data['country'] = this.country;
    data['country_id'] = this.countryId;
    data['telephone'] = this.telephone;
    data['products_weight'] = this.productsWeight;
    data['products_weight_unit'] = this.productsWeightUnit;
    data['language_id'] = this.languageId;
    data['currency_code'] = this.currencyCode;
    if (this.products != null) {
      data['products'] = this.products.map((e) => e.toJson()).toList();
    }
    return data;
  }
}
