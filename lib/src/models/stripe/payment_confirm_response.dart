// To parse this JSON data, do
//
//     final paymentConfirmResponse = paymentConfirmResponseFromMap(jsonString);

import 'dart:convert';

PaymentConfirmResponse paymentConfirmResponseFromMap(String str) =>
    PaymentConfirmResponse.fromMap(json.decode(str));

String paymentConfirmResponseToMap(PaymentConfirmResponse data) =>
    json.encode(data.toMap());

class PaymentConfirmResponse {
  PaymentConfirmResponse({
    this.id,
    this.object,
    this.amount,
    this.amountCapturable,
    this.amountReceived,
    this.application,
    this.applicationFeeAmount,
    this.canceledAt,
    this.cancellationReason,
    this.captureMethod,
    this.charges,
    this.clientSecret,
    this.confirmationMethod,
    this.created,
    this.currency,
    this.customer,
    this.description,
    this.invoice,
    this.lastPaymentError,
    this.livemode,
    this.metadata,
    this.nextAction,
    this.onBehalfOf,
    this.paymentMethod,
    this.paymentMethodOptions,
    this.paymentMethodTypes,
    this.receiptEmail,
    this.review,
    this.setupFutureUsage,
    this.shipping,
    this.source,
    this.statementDescriptor,
    this.statementDescriptorSuffix,
    this.status,
    this.transferData,
    this.transferGroup,
  });

  String id;
  String object;
  int amount;
  int amountCapturable;
  int amountReceived;
  dynamic application;
  dynamic applicationFeeAmount;
  dynamic canceledAt;
  dynamic cancellationReason;
  String captureMethod;
  Charges charges;
  String clientSecret;
  String confirmationMethod;
  int created;
  String currency;
  dynamic customer;
  dynamic description;
  dynamic invoice;
  dynamic lastPaymentError;
  bool livemode;
  Metadata metadata;
  dynamic nextAction;
  dynamic onBehalfOf;
  String paymentMethod;
  PaymentMethodOptions paymentMethodOptions;
  List<String> paymentMethodTypes;
  dynamic receiptEmail;
  dynamic review;
  dynamic setupFutureUsage;
  dynamic shipping;
  dynamic source;
  dynamic statementDescriptor;
  dynamic statementDescriptorSuffix;
  String status;
  dynamic transferData;
  dynamic transferGroup;

  factory PaymentConfirmResponse.fromMap(Map<String, dynamic> json) =>
      PaymentConfirmResponse(
        id: json["id"],
        object: json["object"],
        amount: json["amount"],
        amountCapturable: json["amount_capturable"],
        amountReceived: json["amount_received"],
        application: json["application"],
        applicationFeeAmount: json["application_fee_amount"],
        canceledAt: json["canceled_at"],
        cancellationReason: json["cancellation_reason"],
        captureMethod: json["capture_method"],
        charges: Charges.fromMap(json["charges"]),
        clientSecret: json["client_secret"],
        confirmationMethod: json["confirmation_method"],
        created: json["created"],
        currency: json["currency"],
        customer: json["customer"],
        description: json["description"],
        invoice: json["invoice"],
        lastPaymentError: json["last_payment_error"],
        livemode: json["livemode"],
        metadata: Metadata.fromMap(json["metadata"]),
        nextAction: json["next_action"],
        onBehalfOf: json["on_behalf_of"],
        paymentMethod: json["payment_method"],
        paymentMethodOptions:
            PaymentMethodOptions.fromMap(json["payment_method_options"]),
        paymentMethodTypes:
            List<String>.from(json["payment_method_types"].map((x) => x)),
        receiptEmail: json["receipt_email"],
        review: json["review"],
        setupFutureUsage: json["setup_future_usage"],
        shipping: json["shipping"],
        source: json["source"],
        statementDescriptor: json["statement_descriptor"],
        statementDescriptorSuffix: json["statement_descriptor_suffix"],
        status: json["status"],
        transferData: json["transfer_data"],
        transferGroup: json["transfer_group"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "object": object,
        "amount": amount,
        "amount_capturable": amountCapturable,
        "amount_received": amountReceived,
        "application": application,
        "application_fee_amount": applicationFeeAmount,
        "canceled_at": canceledAt,
        "cancellation_reason": cancellationReason,
        "capture_method": captureMethod,
        "charges": charges.toMap(),
        "client_secret": clientSecret,
        "confirmation_method": confirmationMethod,
        "created": created,
        "currency": currency,
        "customer": customer,
        "description": description,
        "invoice": invoice,
        "last_payment_error": lastPaymentError,
        "livemode": livemode,
        "metadata": metadata.toMap(),
        "next_action": nextAction,
        "on_behalf_of": onBehalfOf,
        "payment_method": paymentMethod,
        "payment_method_options": paymentMethodOptions.toMap(),
        "payment_method_types":
            List<dynamic>.from(paymentMethodTypes.map((x) => x)),
        "receipt_email": receiptEmail,
        "review": review,
        "setup_future_usage": setupFutureUsage,
        "shipping": shipping,
        "source": source,
        "statement_descriptor": statementDescriptor,
        "statement_descriptor_suffix": statementDescriptorSuffix,
        "status": status,
        "transfer_data": transferData,
        "transfer_group": transferGroup,
      };
}

class Datum {
  Datum({
    this.id,
    this.object,
    this.amount,
    this.amountCaptured,
    this.amountRefunded,
    this.application,
    this.applicationFee,
    this.applicationFeeAmount,
    this.balanceTransaction,
    this.billingDetails,
    this.calculatedStatementDescriptor,
    this.captured,
    this.created,
    this.currency,
    this.customer,
    this.description,
    this.destination,
    this.dispute,
    this.disputed,
    this.failureCode,
    this.failureMessage,
    this.fraudDetails,
    this.invoice,
    this.livemode,
    this.metadata,
    this.onBehalfOf,
    this.order,
    this.outcome,
    this.paid,
    this.paymentIntent,
    this.paymentMethod,
    this.paymentMethodDetails,
    this.receiptEmail,
    this.receiptNumber,
    this.receiptUrl,
    this.refunded,
    this.refunds,
    this.review,
    this.shipping,
    this.source,
    this.sourceTransfer,
    this.statementDescriptor,
    this.statementDescriptorSuffix,
    this.status,
    this.transferData,
    this.transferGroup,
  });

  String id;
  String object;
  int amount;
  int amountCaptured;
  int amountRefunded;
  dynamic application;
  dynamic applicationFee;
  dynamic applicationFeeAmount;
  String balanceTransaction;
  BillingDetails billingDetails;
  String calculatedStatementDescriptor;
  bool captured;
  int created;
  String currency;
  dynamic customer;
  dynamic description;
  dynamic destination;
  dynamic dispute;
  bool disputed;
  dynamic failureCode;
  dynamic failureMessage;
  Metadata fraudDetails;
  dynamic invoice;
  bool livemode;
  Metadata metadata;
  dynamic onBehalfOf;
  dynamic order;
  Outcome outcome;
  bool paid;
  String paymentIntent;
  String paymentMethod;
  PaymentMethodDetails paymentMethodDetails;
  dynamic receiptEmail;
  dynamic receiptNumber;
  String receiptUrl;
  bool refunded;
  Charges refunds;
  dynamic review;
  dynamic shipping;
  dynamic source;
  dynamic sourceTransfer;
  dynamic statementDescriptor;
  dynamic statementDescriptorSuffix;
  String status;
  dynamic transferData;
  dynamic transferGroup;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        object: json["object"],
        amount: json["amount"],
        amountCaptured: json["amount_captured"],
        amountRefunded: json["amount_refunded"],
        application: json["application"],
        applicationFee: json["application_fee"],
        applicationFeeAmount: json["application_fee_amount"],
        balanceTransaction: json["balance_transaction"],
        billingDetails: BillingDetails.fromMap(json["billing_details"]),
        calculatedStatementDescriptor: json["calculated_statement_descriptor"],
        captured: json["captured"],
        created: json["created"],
        currency: json["currency"],
        customer: json["customer"],
        description: json["description"],
        destination: json["destination"],
        dispute: json["dispute"],
        disputed: json["disputed"],
        failureCode: json["failure_code"],
        failureMessage: json["failure_message"],
        fraudDetails: Metadata.fromMap(json["fraud_details"]),
        invoice: json["invoice"],
        livemode: json["livemode"],
        metadata: Metadata.fromMap(json["metadata"]),
        onBehalfOf: json["on_behalf_of"],
        order: json["order"],
        outcome: Outcome.fromMap(json["outcome"]),
        paid: json["paid"],
        paymentIntent: json["payment_intent"],
        paymentMethod: json["payment_method"],
        paymentMethodDetails:
            PaymentMethodDetails.fromMap(json["payment_method_details"]),
        receiptEmail: json["receipt_email"],
        receiptNumber: json["receipt_number"],
        receiptUrl: json["receipt_url"],
        refunded: json["refunded"],
        refunds: Charges.fromMap(json["refunds"]),
        review: json["review"],
        shipping: json["shipping"],
        source: json["source"],
        sourceTransfer: json["source_transfer"],
        statementDescriptor: json["statement_descriptor"],
        statementDescriptorSuffix: json["statement_descriptor_suffix"],
        status: json["status"],
        transferData: json["transfer_data"],
        transferGroup: json["transfer_group"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "object": object,
        "amount": amount,
        "amount_captured": amountCaptured,
        "amount_refunded": amountRefunded,
        "application": application,
        "application_fee": applicationFee,
        "application_fee_amount": applicationFeeAmount,
        "balance_transaction": balanceTransaction,
        "billing_details": billingDetails.toMap(),
        "calculated_statement_descriptor": calculatedStatementDescriptor,
        "captured": captured,
        "created": created,
        "currency": currency,
        "customer": customer,
        "description": description,
        "destination": destination,
        "dispute": dispute,
        "disputed": disputed,
        "failure_code": failureCode,
        "failure_message": failureMessage,
        "fraud_details": fraudDetails.toMap(),
        "invoice": invoice,
        "livemode": livemode,
        "metadata": metadata.toMap(),
        "on_behalf_of": onBehalfOf,
        "order": order,
        "outcome": outcome.toMap(),
        "paid": paid,
        "payment_intent": paymentIntent,
        "payment_method": paymentMethod,
        "payment_method_details": paymentMethodDetails.toMap(),
        "receipt_email": receiptEmail,
        "receipt_number": receiptNumber,
        "receipt_url": receiptUrl,
        "refunded": refunded,
        "refunds": refunds.toMap(),
        "review": review,
        "shipping": shipping,
        "source": source,
        "source_transfer": sourceTransfer,
        "statement_descriptor": statementDescriptor,
        "statement_descriptor_suffix": statementDescriptorSuffix,
        "status": status,
        "transfer_data": transferData,
        "transfer_group": transferGroup,
      };
}

class Charges {
  Charges({
    this.object,
    this.data,
    this.hasMore,
    this.totalCount,
    this.url,
  });

  String object;
  List<Datum> data;
  bool hasMore;
  int totalCount;
  String url;

  factory Charges.fromMap(Map<String, dynamic> json) => Charges(
        object: json["object"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        hasMore: json["has_more"],
        totalCount: json["total_count"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "object": object,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "has_more": hasMore,
        "total_count": totalCount,
        "url": url,
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

class Metadata {
  Metadata();

  factory Metadata.fromMap(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toMap() => {};
}

class Outcome {
  Outcome({
    this.networkStatus,
    this.reason,
    this.riskLevel,
    this.sellerMessage,
    this.type,
  });

  String networkStatus;
  dynamic reason;
  String riskLevel;
  String sellerMessage;
  String type;

  factory Outcome.fromMap(Map<String, dynamic> json) => Outcome(
        networkStatus: json["network_status"],
        reason: json["reason"],
        riskLevel: json["risk_level"],
        sellerMessage: json["seller_message"],
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "network_status": networkStatus,
        "reason": reason,
        "risk_level": riskLevel,
        "seller_message": sellerMessage,
        "type": type,
      };
}

class PaymentMethodDetails {
  PaymentMethodDetails({
    this.card,
    this.type,
  });

  PaymentMethodDetailsCard card;
  String type;

  factory PaymentMethodDetails.fromMap(Map<String, dynamic> json) =>
      PaymentMethodDetails(
        card: PaymentMethodDetailsCard.fromMap(json["card"]),
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "card": card.toMap(),
        "type": type,
      };
}

class PaymentMethodDetailsCard {
  PaymentMethodDetailsCard({
    this.brand,
    this.checks,
    this.country,
    this.expMonth,
    this.expYear,
    this.fingerprint,
    this.funding,
    this.installments,
    this.last4,
    this.network,
    this.threeDSecure,
    this.wallet,
  });

  String brand;
  Checks checks;
  String country;
  int expMonth;
  int expYear;
  String fingerprint;
  String funding;
  dynamic installments;
  String last4;
  String network;
  dynamic threeDSecure;
  dynamic wallet;

  factory PaymentMethodDetailsCard.fromMap(Map<String, dynamic> json) =>
      PaymentMethodDetailsCard(
        brand: json["brand"],
        checks: Checks.fromMap(json["checks"]),
        country: json["country"],
        expMonth: json["exp_month"],
        expYear: json["exp_year"],
        fingerprint: json["fingerprint"],
        funding: json["funding"],
        installments: json["installments"],
        last4: json["last4"],
        network: json["network"],
        threeDSecure: json["three_d_secure"],
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
        "installments": installments,
        "last4": last4,
        "network": network,
        "three_d_secure": threeDSecure,
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

class PaymentMethodOptions {
  PaymentMethodOptions({
    this.card,
  });

  PaymentMethodOptionsCard card;

  factory PaymentMethodOptions.fromMap(Map<String, dynamic> json) =>
      PaymentMethodOptions(
        card: PaymentMethodOptionsCard.fromMap(json["card"]),
      );

  Map<String, dynamic> toMap() => {
        "card": card.toMap(),
      };
}

class PaymentMethodOptionsCard {
  PaymentMethodOptionsCard({
    this.installments,
    this.network,
    this.requestThreeDSecure,
  });

  dynamic installments;
  dynamic network;
  String requestThreeDSecure;

  factory PaymentMethodOptionsCard.fromMap(Map<String, dynamic> json) =>
      PaymentMethodOptionsCard(
        installments: json["installments"],
        network: json["network"],
        requestThreeDSecure: json["request_three_d_secure"],
      );

  Map<String, dynamic> toMap() => {
        "installments": installments,
        "network": network,
        "request_three_d_secure": requestThreeDSecure,
      };
}
