// To parse this JSON data, do
//
//     final paymenMethodsOxxoResponse = paymenMethodsOxxoResponseFromMap(jsonString);

import 'dart:convert';

class PaymenMethodsOxxoResponse {
    PaymenMethodsOxxoResponse({
        this.id,
        this.object,
        this.billingDetails,
        this.created,
        this.customer,
        this.livemode,
        this.metadata,
        this.oxxo,
        this.type,
    });

    String id;
    String object;
    BillingDetails billingDetails;
    int created;
    dynamic customer;
    bool livemode;
    Metadata metadata;
    Metadata oxxo;
    String type;

    factory PaymenMethodsOxxoResponse.fromJson(String str) => PaymenMethodsOxxoResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PaymenMethodsOxxoResponse.fromMap(Map<String, dynamic> json) => PaymenMethodsOxxoResponse(
        id: json["id"],
        object: json["object"],
        billingDetails: BillingDetails.fromMap(json["billing_details"]),
        created: json["created"],
        customer: json["customer"],
        livemode: json["livemode"],
        metadata: Metadata.fromMap(json["metadata"]),
        oxxo: Metadata.fromMap(json["oxxo"]),
        type: json["type"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "object": object,
        "billing_details": billingDetails.toMap(),
        "created": created,
        "customer": customer,
        "livemode": livemode,
        "metadata": metadata.toMap(),
        "oxxo": oxxo.toMap(),
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
    String email;
    String name;
    dynamic phone;

    factory BillingDetails.fromJson(String str) => BillingDetails.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

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

    factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

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

class Metadata {
    Metadata();

    factory Metadata.fromJson(String str) => Metadata.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Metadata.fromMap(Map<String, dynamic> json) => Metadata(
    );

    Map<String, dynamic> toMap() => {
    };
}