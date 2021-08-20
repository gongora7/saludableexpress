// To parse this JSON data, do
//
//     final paymentMethodResponse = paymentMethodResponseFromMap(jsonString);

import 'dart:convert';

PaymentMethodResponse paymentMethodResponseFromMap(String str) =>
    PaymentMethodResponse.fromMap(json.decode(str));

String paymentMethodResponseToMap(PaymentMethodResponse data) =>
    json.encode(data.toMap());

class PaymentMethodResponse {
  PaymentMethodResponse({
    this.id,
    this.object,
    this.billingDetails,
    this.card,
    this.created,
    this.customer,
    this.livemode,
    this.metadata,
    this.type,
  });

  String id;
  String object;
  BillingDetails billingDetails;
  Card card;
  int created;
  dynamic customer;
  bool livemode;
  Metadata metadata;
  String type;

  factory PaymentMethodResponse.fromMap(Map<String, dynamic> json) =>
      PaymentMethodResponse(
        id: json["id"],
        object: json["object"],
        billingDetails: BillingDetails.fromMap(json["billing_details"]),
        card: Card.fromMap(json["card"]),
        created: json["created"],
        customer: json["customer"],
        livemode: json["livemode"],
        metadata: Metadata.fromMap(json["metadata"]),
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "object": object,
        "billing_details": billingDetails.toMap(),
        "card": card.toMap(),
        "created": created,
        "customer": customer,
        "livemode": livemode,
        "metadata": metadata.toMap(),
        "type": type,
      };
}

class BillingDetails {
  BillingDetails({
    this.address,
    this.email,
    this.name,
    this.phone,
  });

  Address address;
  dynamic email;
  dynamic name;
  dynamic phone;

  factory BillingDetails.fromMap(Map<String, dynamic> json) => BillingDetails(
        address: Address.fromMap(json["address"]),
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toMap() => {
        "address": address.toMap(),
        "email": email,
        "name": name,
        "phone": phone,
      };
}

class Address {
  Address({
    this.city,
    this.country,
    this.line1,
    this.line2,
    this.postalCode,
    this.state,
  });

  dynamic city;
  dynamic country;
  dynamic line1;
  dynamic line2;
  dynamic postalCode;
  dynamic state;

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        city: json["city"],
        country: json["country"],
        line1: json["line1"],
        line2: json["line2"],
        postalCode: json["postal_code"],
        state: json["state"],
      );

  Map<String, dynamic> toMap() => {
        "city": city,
        "country": country,
        "line1": line1,
        "line2": line2,
        "postal_code": postalCode,
        "state": state,
      };
}

class Card {
  Card({
    this.brand,
    this.checks,
    this.country,
    this.expMonth,
    this.expYear,
    this.fingerprint,
    this.funding,
    this.generatedFrom,
    this.last4,
    this.networks,
    this.threeDSecureUsage,
    this.wallet,
  });

  String brand;
  Checks checks;
  String country;
  int expMonth;
  int expYear;
  String fingerprint;
  String funding;
  dynamic generatedFrom;
  String last4;
  Networks networks;
  ThreeDSecureUsage threeDSecureUsage;
  dynamic wallet;

  factory Card.fromMap(Map<String, dynamic> json) => Card(
        brand: json["brand"],
        checks: Checks.fromMap(json["checks"]),
        country: json["country"],
        expMonth: json["exp_month"],
        expYear: json["exp_year"],
        fingerprint: json["fingerprint"],
        funding: json["funding"],
        generatedFrom: json["generated_from"],
        last4: json["last4"],
        networks: Networks.fromMap(json["networks"]),
        threeDSecureUsage:
            ThreeDSecureUsage.fromMap(json["three_d_secure_usage"]),
        wallet: json["wallet"],
      );

  Map<String, dynamic> toMap() => {
        "brand": brand,
        "checks": checks.toMap(),
        "country": country,
        "exp_month": expMonth,
        "exp_year": expYear,
        "fingerprint": fingerprint,
        "funding": funding,
        "generated_from": generatedFrom,
        "last4": last4,
        "networks": networks.toMap(),
        "three_d_secure_usage": threeDSecureUsage.toMap(),
        "wallet": wallet,
      };
}

class Checks {
  Checks({
    this.addressLine1Check,
    this.addressPostalCodeCheck,
    this.cvcCheck,
  });

  dynamic addressLine1Check;
  dynamic addressPostalCodeCheck;
  String cvcCheck;

  factory Checks.fromMap(Map<String, dynamic> json) => Checks(
        addressLine1Check: json["address_line1_check"],
        addressPostalCodeCheck: json["address_postal_code_check"],
        cvcCheck: json["cvc_check"],
      );

  Map<String, dynamic> toMap() => {
        "address_line1_check": addressLine1Check,
        "address_postal_code_check": addressPostalCodeCheck,
        "cvc_check": cvcCheck,
      };
}

class Networks {
  Networks({
    this.available,
    this.preferred,
  });

  List<String> available;
  dynamic preferred;

  factory Networks.fromMap(Map<String, dynamic> json) => Networks(
        available: List<String>.from(json["available"].map((x) => x)),
        preferred: json["preferred"],
      );

  Map<String, dynamic> toMap() => {
        "available": List<dynamic>.from(available.map((x) => x)),
        "preferred": preferred,
      };
}

class ThreeDSecureUsage {
  ThreeDSecureUsage({
    this.supported,
  });

  bool supported;

  factory ThreeDSecureUsage.fromMap(Map<String, dynamic> json) =>
      ThreeDSecureUsage(
        supported: json["supported"],
      );

  Map<String, dynamic> toMap() => {
        "supported": supported,
      };
}

class Metadata {
  Metadata();

  factory Metadata.fromMap(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toMap() => {};
}