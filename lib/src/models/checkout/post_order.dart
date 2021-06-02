import 'package:flutter_app1/src/models/checkout/post_product.dart';

import 'coupon.dart';

class PostOrder {
  String billing_city;
  String billing_country;
  String billing_country_id;
  String billing_firstname;
  String billing_lastname;
  String billing_phone;
  String billing_postcode;
  String billing_state;
  String billing_street_address;
  String billing_suburb;
  String billing_zone;
  String billing_zone_id;
  String comments;
  var coupon_amount;
  List<Coupon> coupons;
  String email;
  String customers_id;
  String customers_name;
  String customers_telephone;
  String delivery_city;
  String delivery_country;
  String delivery_country_id;
  String delivery_firstname;
  String delivery_lastname;
  String delivery_phone;
  String delivery_postcode;
  String delivery_state;
  String delivery_street_address;
  String delivery_suburb;
  String delivery_zone;
  String delivery_zone_id;
  String delivery_cost;
  String delivery_time;
  String is_coupon_applied;
  String language_id;
  String latitude;
  String longitude;
  String nonce;
  String packing_charge_tax;
  String payment_method;
  String currency_code;
  List<PostProduct> products;
  var productsTotal;
  var shipping_cost;
  String shipping_method;
  String tax_zone_id;
  var totalPrice;
  var total_tax;
  String transaction_id;
  String guest_status;

  PostOrder(
      {this.billing_city,
      this.billing_country,
      this.billing_country_id,
      this.billing_firstname,
      this.billing_lastname,
      this.billing_phone,
      this.billing_postcode,
      this.billing_state,
      this.billing_street_address,
      this.billing_suburb,
      this.billing_zone,
      this.billing_zone_id,
      this.comments,
      this.coupon_amount,
      this.coupons,
      this.email,
      this.customers_id,
      this.customers_name,
      this.customers_telephone,
      this.delivery_city,
      this.delivery_country,
      this.delivery_country_id,
      this.delivery_firstname,
      this.delivery_lastname,
      this.delivery_phone,
      this.delivery_postcode,
      this.delivery_state,
      this.delivery_street_address,
      this.delivery_suburb,
      this.delivery_zone,
      this.delivery_zone_id,
      this.delivery_cost,
      this.delivery_time,
      this.is_coupon_applied,
      this.language_id,
      this.latitude,
      this.longitude,
      this.nonce,
      this.packing_charge_tax,
      this.payment_method,
      this.currency_code,
      this.products,
      this.productsTotal,
      this.shipping_cost,
      this.shipping_method,
      this.tax_zone_id,
      this.totalPrice,
      this.total_tax,
      this.transaction_id,
      this.guest_status});

  PostOrder.fromJson(Map<String, dynamic> json) {
    billing_city = json['billing_city'];
    billing_country = json['billing_country'];
    billing_country_id = json['billing_country_id'];
    billing_firstname = json['billing_firstname'];
    billing_lastname = json['billing_lastname'];
    billing_phone = json['billing_phone'];
    billing_postcode = json['billing_postcode'];
    billing_state = json['billing_state'];
    billing_street_address = json['billing_street_address'];
    billing_suburb = json['billing_suburb'];
    billing_zone = json['billing_zone'];
    billing_zone_id = json['billing_zone_id'];
    comments = json['comments'];
    coupon_amount = json['coupon_amount'];
    if (json['coupons'] != null) {
      coupons = new List<Coupon>();
      json['coupons'].forEach((v) {
        coupons.add(new Coupon.fromJson(v));
      });
    }
    email = json['email'];
    customers_id = json['customers_id'];
    customers_name = json['customers_name'];
    customers_telephone = json['customers_telephone'];
    delivery_city = json['delivery_city'];
    delivery_country = json['delivery_country'];
    delivery_country_id = json['delivery_country_id'];
    delivery_firstname = json['delivery_firstname'];
    delivery_lastname = json['delivery_lastname'];
    delivery_phone = json['delivery_phone'];
    delivery_postcode = json['delivery_postcode'];
    delivery_state = json['delivery_state'];
    delivery_street_address = json['delivery_street_address'];
    delivery_suburb = json['delivery_suburb'];
    delivery_zone = json['delivery_zone'];
    delivery_zone_id = json['delivery_zone_id'];
    delivery_cost = json['delivery_cost'];
    delivery_time = json['delivery_time'];
    is_coupon_applied = json['is_coupon_applied'];
    language_id = json['language_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    nonce = json['nonce'];
    packing_charge_tax = json['packing_charge_tax'];
    payment_method = json['payment_method'];
    currency_code = json['currency_code'];
    if (json['products'] != null) {
      products = new List<PostProduct>();
      json['products'].forEach((v) {
        products.add(new PostProduct.fromJson(v));
      });
    }
    productsTotal = json['productsTotal'];
    shipping_cost = json['shipping_cost'];
    shipping_method = json['shipping_method'];
    tax_zone_id = json['tax_zone_id'];
    totalPrice = json['totalPrice'];
    total_tax = json['total_tax'];
    transaction_id = json['transaction_id'];
    guest_status = json['guest_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['billing_city'] = this.billing_city;
    data['billing_country'] = this.billing_country;
    data['billing_country_id'] = this.billing_country_id;
    data['billing_firstname'] = this.billing_firstname;
    data['billing_lastname'] = this.billing_lastname;
    data['billing_phone'] = this.billing_phone;
    data['billing_postcode'] = this.billing_postcode;
    data['billing_state'] = this.billing_state;
    data['billing_street_address'] = this.billing_street_address;
    data['billing_suburb'] = this.billing_suburb;
    data['billing_zone'] = this.billing_zone;
    data['billing_zone_id'] = this.billing_zone_id;
    data['comments'] = this.comments;
    data['coupon_amount'] = this.coupon_amount;
    if (this.coupons != null) {
      data['coupons'] = this.coupons.map((e) => e.tojson()).toList();
    }
    data['email'] = this.email;
    data['customers_id'] = this.customers_id;
    data['customers_name'] = this.customers_name;
    data['customers_telephone'] = this.customers_telephone;
    data['delivery_city'] = this.delivery_city;
    data['delivery_country'] = this.delivery_country;
    data['delivery_country_id'] = this.delivery_country_id;
    data['delivery_firstname'] = this.delivery_firstname;
    data['delivery_lastname'] = this.delivery_lastname;
    data['delivery_phone'] = this.delivery_phone;
    data['delivery_postcode'] = this.delivery_postcode;
    data['delivery_state'] = this.delivery_state;
    data['delivery_street_address'] = this.delivery_street_address;
    data['delivery_suburb'] = this.delivery_suburb;
    data['delivery_zone'] = this.delivery_zone;
    data['delivery_zone_id'] = this.delivery_zone_id;
    data['delivery_cost'] = this.delivery_cost;
    data['delivery_time'] = this.delivery_time;
    data['is_coupon_applied'] = this.is_coupon_applied;
    data['language_id'] = this.language_id;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['nonce'] = this.nonce;
    data['packing_charge_tax'] = this.packing_charge_tax;
    data['payment_method'] = this.payment_method;
    data['currency_code'] = this.currency_code;
    if (this.products != null) {
      data['products'] = this.products.map((e) => e.toJson()).toList();
    }
    data['productsTotal'] = this.productsTotal;
    data['shipping_cost'] = this.shipping_cost;
    data['shipping_method'] = this.shipping_method;
    data['tax_zone_id'] = this.tax_zone_id;
    data['totalPrice'] = this.totalPrice;
    data['total_tax'] = this.total_tax;
    data['transaction_id'] = this.transaction_id;
    data['guest_status'] = this.guest_status;
    return data;
  }
}
