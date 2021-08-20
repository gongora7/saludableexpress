// To parse this JSON data, do
//
//     final paymentIntentOxxoResponse = paymentIntentOxxoResponseFromMap(jsonString);

import 'dart:convert';

class PaymentConfirmOxxoResponse {
    PaymentConfirmOxxoResponse({
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
    NextAction nextAction;
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

    factory PaymentConfirmOxxoResponse.fromJson(String str) => PaymentConfirmOxxoResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PaymentConfirmOxxoResponse.fromMap(Map<String, dynamic> json) => PaymentConfirmOxxoResponse(
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
        nextAction: NextAction.fromMap(json["next_action"]),
        onBehalfOf: json["on_behalf_of"],
        paymentMethod: json["payment_method"],
        paymentMethodOptions: PaymentMethodOptions.fromMap(json["payment_method_options"]),
        paymentMethodTypes: List<String>.from(json["payment_method_types"].map((x) => x)),
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
        "next_action": nextAction.toMap(),
        "on_behalf_of": onBehalfOf,
        "payment_method": paymentMethod,
        "payment_method_options": paymentMethodOptions.toMap(),
        "payment_method_types": List<dynamic>.from(paymentMethodTypes.map((x) => x)),
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

class Charges {
    Charges({
        this.object,
        this.data,
        this.hasMore,
        this.totalCount,
        this.url,
    });

    String object;
    List<dynamic> data;
    bool hasMore;
    int totalCount;
    String url;

    factory Charges.fromJson(String str) => Charges.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Charges.fromMap(Map<String, dynamic> json) => Charges(
        object: json["object"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
        hasMore: json["has_more"],
        totalCount: json["total_count"],
        url: json["url"],
    );

    Map<String, dynamic> toMap() => {
        "object": object,
        "data": List<dynamic>.from(data.map((x) => x)),
        "has_more": hasMore,
        "total_count": totalCount,
        "url": url,
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

class NextAction {
    NextAction({
        this.oxxoDisplayDetails,
        this.type,
    });

    OxxoDisplayDetails oxxoDisplayDetails;
    String type;

    factory NextAction.fromJson(String str) => NextAction.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory NextAction.fromMap(Map<String, dynamic> json) => NextAction(
        oxxoDisplayDetails: OxxoDisplayDetails.fromMap(json["oxxo_display_details"]),
        type: json["type"],
    );

    Map<String, dynamic> toMap() => {
        "oxxo_display_details": oxxoDisplayDetails.toMap(),
        "type": type,
    };
}

class OxxoDisplayDetails {
    OxxoDisplayDetails({
        this.expiresAfter,
        this.hostedVoucherUrl,
        this.number,
    });

    int expiresAfter;
    String hostedVoucherUrl;
    String number;

    factory OxxoDisplayDetails.fromJson(String str) => OxxoDisplayDetails.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory OxxoDisplayDetails.fromMap(Map<String, dynamic> json) => OxxoDisplayDetails(
        expiresAfter: json["expires_after"],
        hostedVoucherUrl: json["hosted_voucher_url"],
        number: json["number"],
    );

    Map<String, dynamic> toMap() => {
        "expires_after": expiresAfter,
        "hosted_voucher_url": hostedVoucherUrl,
        "number": number,
    };
}

class PaymentMethodOptions {
    PaymentMethodOptions({
        this.oxxo,
    });

    Oxxo oxxo;

    factory PaymentMethodOptions.fromJson(String str) => PaymentMethodOptions.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PaymentMethodOptions.fromMap(Map<String, dynamic> json) => PaymentMethodOptions(
        oxxo: Oxxo.fromMap(json["oxxo"]),
    );

    Map<String, dynamic> toMap() => {
        "oxxo": oxxo.toMap(),
    };
}

class Oxxo {
    Oxxo({
        this.expiresAfterDays,
    });

    int expiresAfterDays;

    factory Oxxo.fromJson(String str) => Oxxo.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Oxxo.fromMap(Map<String, dynamic> json) => Oxxo(
        expiresAfterDays: json["expires_after_days"],
    );

    Map<String, dynamic> toMap() => {
        "expires_after_days": expiresAfterDays,
    };
}
