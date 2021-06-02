class Coupon {
  String coupans_id;
  String code;
  String amount;
  String discount;
  String discount_type;
  String date_created;
  String date_modified;
  String description;
  String expiry_date;
  String usage_count;
  String individual_use;
  List<String> product_ids;
  List<String> exclude_product_ids;
  String usage_limit;
  String usage_limit_per_user;
  String limit_usage_to_x_items;
  String free_shipping;
  List<String> product_categories;
  List<String> excluded_product_categories;
  String exclude_sale_items;
  String minimum_amount;
  String maximum_amount;
  List<String> email_restrictions;
  List<String> used_by;

  Coupon(
      {this.coupans_id,
      this.code,
      this.amount,
      this.discount,
      this.discount_type,
      this.date_created,
      this.date_modified,
      this.description,
      this.expiry_date,
      this.usage_count,
      this.individual_use,
      this.product_ids,
      this.exclude_product_ids,
      this.usage_limit,
      this.usage_limit_per_user,
      this.limit_usage_to_x_items,
      this.free_shipping,
      this.product_categories,
      this.excluded_product_categories,
      this.exclude_sale_items,
      this.minimum_amount,
      this.maximum_amount,
      this.email_restrictions,
      this.used_by});

  Coupon.fromJson(Map<String, dynamic> json) {
    coupans_id = json['coupans_id'];
    code = json['code'];
    amount = json['amount'];
    discount = json['discount'];
    discount_type = json['discount_type'];
    date_created = json['date_created'];
    date_modified = json['date_modified'];
    description = json['description'];
    expiry_date = json['expiry_date'];
    usage_count = json['usage_count'];
    individual_use = json['individual_use'];
    if (json['product_ids'] != null) {
      product_ids = new List<String>();
      json['product_ids'].forEach((v) {
        product_ids.add(v);
      });
    }
    if (json['exclude_product_ids'] != null) {
      exclude_product_ids = new List<String>();
      json['exclude_product_ids'].forEach((v) {
        exclude_product_ids.add(v);
      });
    }
    usage_limit = json['usage_limit'];
    usage_limit_per_user = json['usage_limit_per_user'];
    limit_usage_to_x_items = json['limit_usage_to_x_items'];
    free_shipping = json['free_shipping'];
    if (json['product_categories'] != null) {
      product_categories = new List<String>();
      json['product_categories'].forEach((v) {
        product_categories.add(v);
      });
    }
    if (json['excluded_product_categories'] != null) {
      excluded_product_categories = new List<String>();
      json['excluded_product_categories'].forEach((v) {
        excluded_product_categories.add(v);
      });
    }
    exclude_sale_items = json['exclude_sale_items'];
    minimum_amount = json['minimum_amount'];
    maximum_amount = json['maximum_amount'];
    if (json['email_restrictions'] != null) {
      email_restrictions = new List<String>();
      json['email_restrictions'].forEach((v) {
        email_restrictions.add(v);
      });
    }
    if (json['used_by'] != null) {
      used_by = new List<String>();
      json['used_by'].forEach((v) {
        used_by.add(v);
      });
    }
  }

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coupans_id'] = this.coupans_id;
    data['code'] = this.code;
    data['amount'] = this.amount;
    data['discount'] = this.discount;
    data['discount_type'] = this.discount_type;
    data['date_created'] = this.date_created;
    data['date_modified'] = this.date_modified;
    data['description'] = this.description;
    data['expiry_date'] = this.expiry_date;
    data['usage_count'] = this.usage_count;
    data['individual_use'] = this.individual_use;
    if (this.product_ids != null) {
      data['product_ids'] = this.product_ids.toList();
    }
    if (this.exclude_product_ids != null) {
      data['exclude_product_ids'] = this.exclude_product_ids.toList();
    }
    data['usage_limit'] = this.usage_limit;
    data['usage_limit_per_user'] = this.usage_limit_per_user;
    data['limit_usage_to_x_items'] = this.limit_usage_to_x_items;
    data['free_shipping'] = this.free_shipping;
    if (this.product_categories != null) {
      data['product_categories'] = this.product_categories.toList();
    }
    if (this.excluded_product_categories != null) {
      data['excluded_product_categories'] =
          this.excluded_product_categories.toList();
    }
    data['exclude_sale_items'] = this.exclude_sale_items;
    data['minimum_amount'] = this.minimum_amount;
    data['maximum_amount'] = this.maximum_amount;
    if (this.email_restrictions != null) {
      data['email_restrictions'] = this.email_restrictions.toList();
    }
    if (this.used_by != null) {
      data['used_by'] = this.used_by.toList();
    }

    return data;
  }
}
