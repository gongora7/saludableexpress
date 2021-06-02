import 'order_product.dart';

class OrderData {
  int ordersId;
  var totalTax;
  int customersId;
  String customersName;
  String customersCompany;
  String customersStreetAddress;
  String customersSuburb;
  String customersCity;
  String customersPostcode;
  String customersState;
  String customersCountry;
  String customersTelephone;
  String email;
  String customersAddressFormatId;
  String deliveryName;
  String deliveryCompany;
  String deliveryStreetAddress;
  String deliverySuburb;
  String deliveryCity;
  String deliveryPostcode;
  String deliveryState;
  String deliveryCountry;
  String deliveryAddressFormatId;
  String billingName;
  String billingCompany;
  String billingStreetAddress;
  String billingSuburb;
  String billingCity;
  String billingPostcode;
  String billingState;
  String billingCountry;
  int billingAddressFormatId;
  String paymentMethod;
  String ccType;
  String ccOwner;
  String ccNumber;
  String ccExpires;
  String lastModified;
  String datePurchased;
  String ordersDateFinished;
  String currency;
  String currencyValue;
  var orderPrice;
  var shippingCost;
  String shippingMethod;
  String shippingDuration;
  String orderInformation;
  int isSeen;
  int couponAmount;
  int freeShipping;
  int orderedSource;
  String deliveryPhone;
  String billingPhone;
  String transactionId;
  String createdAt;
  String updatedAt;
  String deliveryTime;
  String deliveryLatitude;
  String deliveryLongitude;
  int ordersStatusId;
  String ordersStatus;
  String customerComments;
  String adminComments;
  List<OrderProduct> data;

  OrderData(
      {this.ordersId,
        this.totalTax,
        this.customersId,
        this.customersName,
        this.customersCompany,
        this.customersStreetAddress,
        this.customersSuburb,
        this.customersCity,
        this.customersPostcode,
        this.customersState,
        this.customersCountry,
        this.customersTelephone,
        this.email,
        this.customersAddressFormatId,
        this.deliveryName,
        this.deliveryCompany,
        this.deliveryStreetAddress,
        this.deliverySuburb,
        this.deliveryCity,
        this.deliveryPostcode,
        this.deliveryState,
        this.deliveryCountry,
        this.deliveryAddressFormatId,
        this.billingName,
        this.billingCompany,
        this.billingStreetAddress,
        this.billingSuburb,
        this.billingCity,
        this.billingPostcode,
        this.billingState,
        this.billingCountry,
        this.billingAddressFormatId,
        this.paymentMethod,
        this.ccType,
        this.ccOwner,
        this.ccNumber,
        this.ccExpires,
        this.lastModified,
        this.datePurchased,
        this.ordersDateFinished,
        this.currency,
        this.currencyValue,
        this.orderPrice,
        this.shippingCost,
        this.shippingMethod,
        this.shippingDuration,
        this.orderInformation,
        this.isSeen,
        this.couponAmount,
        this.freeShipping,
        this.orderedSource,
        this.deliveryPhone,
        this.billingPhone,
        this.transactionId,
        this.createdAt,
        this.updatedAt,
        this.deliveryTime,
        this.deliveryLatitude,
        this.deliveryLongitude,
        this.ordersStatusId,
        this.ordersStatus,
        this.customerComments,
        this.adminComments,
        this.data});

  OrderData.fromJson(Map<String, dynamic> json) {
    ordersId = json['orders_id'];
    totalTax = json['total_tax'];
    customersId = json['customers_id'];
    customersName = json['customers_name'];
    customersCompany = json['customers_company'];
    customersStreetAddress = json['customers_street_address'];
    customersSuburb = json['customers_suburb'];
    customersCity = json['customers_city'];
    customersPostcode = json['customers_postcode'];
    customersState = json['customers_state'];
    customersCountry = json['customers_country'];
    customersTelephone = json['customers_telephone'];
    email = json['email'];
    customersAddressFormatId = json['customers_address_format_id'];
    deliveryName = json['delivery_name'];
    deliveryCompany = json['delivery_company'];
    deliveryStreetAddress = json['delivery_street_address'];
    deliverySuburb = json['delivery_suburb'];
    deliveryCity = json['delivery_city'];
    deliveryPostcode = json['delivery_postcode'];
    deliveryState = json['delivery_state'];
    deliveryCountry = json['delivery_country'];
    deliveryAddressFormatId = json['delivery_address_format_id'];
    billingName = json['billing_name'];
    billingCompany = json['billing_company'];
    billingStreetAddress = json['billing_street_address'];
    billingSuburb = json['billing_suburb'];
    billingCity = json['billing_city'];
    billingPostcode = json['billing_postcode'];
    billingState = json['billing_state'];
    billingCountry = json['billing_country'];
    billingAddressFormatId = json['billing_address_format_id'];
    paymentMethod = json['payment_method'];
    ccType = json['cc_type'];
    ccOwner = json['cc_owner'];
    ccNumber = json['cc_number'];
    ccExpires = json['cc_expires'];
    lastModified = json['last_modified'];
    datePurchased = json['date_purchased'];
    ordersDateFinished = json['orders_date_finished'];
    currency = json['currency'];
    currencyValue = json['currency_value'];
    orderPrice = json['order_price'];
    shippingCost = json['shipping_cost'];
    shippingMethod = json['shipping_method'];
    shippingDuration = json['shipping_duration'];
    orderInformation = json['order_information'];
    isSeen = json['is_seen'];
    couponAmount = json['coupon_amount'];
    orderedSource = json['ordered_source'];
    deliveryPhone = json['delivery_phone'];
    billingPhone = json['billing_phone'];
    transactionId = json['transaction_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deliveryTime = json['delivery_time'];
    deliveryLatitude = json['delivery_latitude'];
    deliveryLongitude = json['delivery_longitude'];
    ordersStatusId = json['orders_status_id'];
    ordersStatus = json['orders_status'];
    customerComments = json['customer_comments'];
    adminComments = json['admin_comments'];
    if (json['data'] != null) {
      data = new List<OrderProduct>();
      json['data'].forEach((v) {
        data.add(new OrderProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orders_id'] = this.ordersId;
    data['total_tax'] = this.totalTax;
    data['customers_id'] = this.customersId;
    data['customers_name'] = this.customersName;
    data['customers_company'] = this.customersCompany;
    data['customers_street_address'] = this.customersStreetAddress;
    data['customers_suburb'] = this.customersSuburb;
    data['customers_city'] = this.customersCity;
    data['customers_postcode'] = this.customersPostcode;
    data['customers_state'] = this.customersState;
    data['customers_country'] = this.customersCountry;
    data['customers_telephone'] = this.customersTelephone;
    data['email'] = this.email;
    data['customers_address_format_id'] = this.customersAddressFormatId;
    data['delivery_name'] = this.deliveryName;
    data['delivery_company'] = this.deliveryCompany;
    data['delivery_street_address'] = this.deliveryStreetAddress;
    data['delivery_suburb'] = this.deliverySuburb;
    data['delivery_city'] = this.deliveryCity;
    data['delivery_postcode'] = this.deliveryPostcode;
    data['delivery_state'] = this.deliveryState;
    data['delivery_country'] = this.deliveryCountry;
    data['delivery_address_format_id'] = this.deliveryAddressFormatId;
    data['billing_name'] = this.billingName;
    data['billing_company'] = this.billingCompany;
    data['billing_street_address'] = this.billingStreetAddress;
    data['billing_suburb'] = this.billingSuburb;
    data['billing_city'] = this.billingCity;
    data['billing_postcode'] = this.billingPostcode;
    data['billing_state'] = this.billingState;
    data['billing_country'] = this.billingCountry;
    data['billing_address_format_id'] = this.billingAddressFormatId;
    data['payment_method'] = this.paymentMethod;
    data['cc_type'] = this.ccType;
    data['cc_owner'] = this.ccOwner;
    data['cc_number'] = this.ccNumber;
    data['cc_expires'] = this.ccExpires;
    data['last_modified'] = this.lastModified;
    data['date_purchased'] = this.datePurchased;
    data['orders_date_finished'] = this.ordersDateFinished;
    data['currency'] = this.currency;
    data['currency_value'] = this.currencyValue;
    data['order_price'] = this.orderPrice;
    data['shipping_cost'] = this.shippingCost;
    data['shipping_method'] = this.shippingMethod;
    data['shipping_duration'] = this.shippingDuration;
    data['order_information'] = this.orderInformation;
    data['is_seen'] = this.isSeen;
    data['coupon_amount'] = this.couponAmount;
    data['ordered_source'] = this.orderedSource;
    data['delivery_phone'] = this.deliveryPhone;
    data['billing_phone'] = this.billingPhone;
    data['transaction_id'] = this.transactionId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['delivery_time'] = this.deliveryTime;
    data['delivery_latitude'] = this.deliveryLatitude;
    data['delivery_longitude'] = this.deliveryLongitude;
    data['orders_status_id'] = this.ordersStatusId;
    data['orders_status'] = this.ordersStatus;
    data['customer_comments'] = this.customerComments;
    data['admin_comments'] = this.adminComments;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}