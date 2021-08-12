// To parse this JSON data, do
//
//     final cuponResponse = cuponResponseFromJson(jsonString);

import 'dart:convert';

CuponResponse cuponResponseFromJson(String str) =>
    CuponResponse.fromJson(json.decode(str));

String cuponResponseToJson(CuponResponse data) => json.encode(data.toJson());

class CuponResponse {
  String success;
  List<Datum> data;
  String message;
  int error;

  CuponResponse({this.success, this.data, this.message, this.error});

  factory CuponResponse.fromJson(Map<String, dynamic> json) => CuponResponse(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  Datum({
    this.coupansId,
    this.code,
    this.dateCreated,
    this.dateModified,
    this.description,
    this.discountType,
    this.amount,
    this.expiryDate,
    this.usageCount,
    this.individualUse,
    this.productIds,
    this.excludeProductIds,
    this.usageLimit,
    this.usageLimitPerUser,
    this.limitUsageToXItems,
    this.freeShipping,
    this.productCategories,
    this.excludedProductCategories,
    this.excludeSaleItems,
    this.minimumAmount,
    this.maximumAmount,
    this.emailRestrictions,
    this.usedBy,
    this.createdAt,
    this.updatedAt,
  });

  String coupansId;
  String code;
  String dateCreated;
  String dateModified;
  String description;
  String discountType;
  String amount;
  DateTime expiryDate;
  String usageCount;
  String individualUse;
  List<dynamic> productIds;
  List<dynamic> excludeProductIds;
  String usageLimit;
  String usageLimitPerUser;
  String limitUsageToXItems;
  String freeShipping;
  List<dynamic> productCategories;
  List<dynamic> excludedProductCategories;
  String excludeSaleItems;
  String minimumAmount;
  String maximumAmount;
  List<dynamic> emailRestrictions;
  List<dynamic> usedBy;
  DateTime createdAt;
  String updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        coupansId: json["coupans_id"],
        code: json["code"],
        dateCreated: json["date_created"],
        dateModified: json["date_modified"],
        description: json["description"],
        discountType: json["discount_type"],
        amount: json["amount"],
        expiryDate: DateTime.parse(json["expiry_date"]),
        usageCount: json["usage_count"],
        individualUse: json["individual_use"],
        productIds: List<dynamic>.from(json["product_ids"].map((x) => x)),
        excludeProductIds:
            List<dynamic>.from(json["exclude_product_ids"].map((x) => x)),
        usageLimit: json["usage_limit"],
        usageLimitPerUser: json["usage_limit_per_user"],
        limitUsageToXItems: json["limit_usage_to_x_items"],
        freeShipping: json["free_shipping"],
        productCategories:
            List<dynamic>.from(json["product_categories"].map((x) => x)),
        excludedProductCategories: List<dynamic>.from(
            json["excluded_product_categories"].map((x) => x)),
        excludeSaleItems: json["exclude_sale_items"],
        minimumAmount: json["minimum_amount"],
        maximumAmount: json["maximum_amount"],
        emailRestrictions:
            List<dynamic>.from(json["email_restrictions"].map((x) => x)),
        usedBy: List<dynamic>.from(json["used_by"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "coupans_id": coupansId,
        "code": code,
        "date_created": dateCreated,
        "date_modified": dateModified,
        "description": description,
        "discount_type": discountType,
        "amount": amount,
        "expiry_date": expiryDate.toIso8601String(),
        "usage_count": usageCount,
        "individual_use": individualUse,
        "product_ids": List<dynamic>.from(productIds.map((x) => x)),
        "exclude_product_ids":
            List<dynamic>.from(excludeProductIds.map((x) => x)),
        "usage_limit": usageLimit,
        "usage_limit_per_user": usageLimitPerUser,
        "limit_usage_to_x_items": limitUsageToXItems,
        "free_shipping": freeShipping,
        "product_categories":
            List<dynamic>.from(productCategories.map((x) => x)),
        "excluded_product_categories":
            List<dynamic>.from(excludedProductCategories.map((x) => x)),
        "exclude_sale_items": excludeSaleItems,
        "minimum_amount": minimumAmount,
        "maximum_amount": maximumAmount,
        "email_restrictions":
            List<dynamic>.from(emailRestrictions.map((x) => x)),
        "used_by": List<dynamic>.from(usedBy.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
      };
}
