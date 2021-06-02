import 'customer_review.dart';
import 'productImage.dart';
import 'product_attributes.dart';
import 'product_category.dart';

class Product {
  int serverTime;
  int productsId;
  int productsQuantity;
  int customerBasketQuantity;
  String productsModel;
  String productsImage;
  String productsVideoLink;
  var productsPrice;
  String productsDateAdded;
  String productsLastModified;
  String productsDateAvailable;
  String productsWeight;
  String productsWeightUnit;
  int productsStatus;
  int isCurrent;
  int productsTaxClassId;
  int manufacturersId;
  int productsOrdered;
  int productsLiked;
  int lowLimit;
  int isFeature;
  String productsSlug;
  int productsType;
  int productsMinOrder;
  int productsMaxStock;
  String createdAt;
  String updatedAt;
  String currency;
  int id;
  int languageId;
  String productsName;
  String productsDescription;
  String productsUrl;
  int productsViewed;
  String productsLeftBanner;
  int productsLeftBannerStartDate;
  int productsLeftBannerExpireDate;
  String productsRightBanner;
  int productsRightBannerStartDate;
  int productsRightBannerExpireDate;
  String manufacturerName;
  String manufacturerImage;
  String manufacturersSlug;
  String dateAdded;
  String lastModified;
  String manufacturersImage;
  String manufacturersUrl;
  var discountPrice;
  List<ProductImages> images;
  List<ProductCategory> categories;
  String rating;
  int totalUserRated;
  int fiveRatio;
  int fourRatio;
  int threeRatio;
  int twoRatio;
  int oneRatio;
  List<CustomerReview> reviewedCustomers;
  int defaultStock;
  String isLiked;
  List<ProductAttribute> attributes;

  Product(
      {this.serverTime,
      this.productsId,
      this.productsQuantity,
      this.customerBasketQuantity,
      this.productsModel,
      this.productsImage,
      this.productsVideoLink,
      this.productsPrice,
      this.productsDateAdded,
      this.productsLastModified,
      this.productsDateAvailable,
      this.productsWeight,
      this.productsWeightUnit,
      this.productsStatus,
      this.isCurrent,
      this.productsTaxClassId,
      this.manufacturersId,
      this.productsOrdered,
      this.productsLiked,
      this.lowLimit,
      this.isFeature,
      this.productsSlug,
      this.productsType,
      this.productsMinOrder,
      this.productsMaxStock,
      this.createdAt,
      this.updatedAt,
      this.currency,
      this.id,
      this.languageId,
      this.productsName,
      this.productsDescription,
      this.productsUrl,
      this.productsViewed,
      this.productsLeftBanner,
      this.productsLeftBannerStartDate,
      this.productsLeftBannerExpireDate,
      this.productsRightBanner,
      this.productsRightBannerStartDate,
      this.productsRightBannerExpireDate,
      this.manufacturerName,
      this.manufacturerImage,
      this.manufacturersSlug,
      this.dateAdded,
      this.lastModified,
      this.manufacturersImage,
      this.manufacturersUrl,
      this.discountPrice,
      this.images,
      this.categories,
      this.rating,
      this.totalUserRated,
      this.fiveRatio,
      this.fourRatio,
      this.threeRatio,
      this.twoRatio,
      this.oneRatio,
      this.reviewedCustomers,
      this.defaultStock,
      this.isLiked,
      this.attributes});

  Product.fromJson(Map<String, dynamic> json) {
    serverTime = json['server_time'];
    productsId = json['products_id'];
    productsQuantity = json['products_quantity'];
    customerBasketQuantity = json['customers_basket_quantity'];
    productsModel = json['products_model'];
    productsImage = json['products_image'];
    productsVideoLink = json['products_video_link'];
    productsPrice = json['products_price'];
    productsDateAdded = json['products_date_added'];
    productsLastModified = json['products_last_modified'];
    productsDateAvailable = json['products_date_available'];
    productsWeight = json['products_weight'];
    productsWeightUnit = json['products_weight_unit'];
    productsStatus = json['products_status'];
    isCurrent = json['is_current'];
    productsTaxClassId = json['products_tax_class_id'];
    manufacturersId = json['manufacturers_id'];
    productsOrdered = json['products_ordered'];
    productsLiked = json['products_liked'];
    lowLimit = json['low_limit'];
    isFeature = json['is_feature'];
    productsSlug = json['products_slug'];
    productsType = json['products_type'];
    productsMinOrder = json['products_min_order'];
    productsMaxStock = json['products_max_stock'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    currency = json['currency'];
    id = json['id'];
    languageId = json['language_id'];
    productsName = json['products_name'];
    productsDescription = json['products_description'];
    productsUrl = json['products_url'];
    productsViewed = json['products_viewed'];
    productsLeftBanner = json['products_left_banner'];
    productsLeftBannerStartDate = json['products_left_banner_start_date'];
    productsLeftBannerExpireDate = json['products_left_banner_expire_date'];
    productsRightBanner = json['products_right_banner'];
    productsRightBannerStartDate = json['products_right_banner_start_date'];
    productsRightBannerExpireDate = json['products_right_banner_expire_date'];
    manufacturerName = json['manufacturer_name'];
    manufacturerImage = json['manufacturer_image'];
    manufacturersSlug = json['manufacturers_slug'];
    dateAdded = json['date_added'];
    lastModified = json['last_modified'];
    manufacturersImage = json['manufacturers_image'];
    manufacturersUrl = json['manufacturers_url'];
    discountPrice = json['discount_price'];
    if (json['images'] != String) {
      images = new List<ProductImages>();
      json['images'].forEach((v) {
        images.add(new ProductImages.fromJson(v));
      });
    }
    if (json['categories'] != String) {
      categories = new List<ProductCategory>();
      json['categories'].forEach((v) {
        categories.add(new ProductCategory.fromJson(v));
      });
    }
    rating = json['rating'];
    totalUserRated = json['total_user_rated'];
    fiveRatio = json['five_ratio'];
    fourRatio = json['four_ratio'];
    threeRatio = json['three_ratio'];
    twoRatio = json['two_ratio'];
    oneRatio = json['one_ratio'];
    if (json['reviewed_customers'] != String) {
      reviewedCustomers = new List<CustomerReview>();
      json['reviewed_customers'].forEach((v) {
        reviewedCustomers.add(new CustomerReview.fromJson(v));
      });
    }
    defaultStock = json['defaultStock'];
    isLiked = json['isLiked'];
    if (json['attributes'] != String) {
      attributes = new List<ProductAttribute>();
      json['attributes'].forEach((v) {
        attributes.add(new ProductAttribute.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['server_time'] = this.serverTime;
    data['products_id'] = this.productsId;
    data['products_quantity'] = this.productsQuantity;
    data['customers_basket_quantity'] = this.customerBasketQuantity;
    data['products_model'] = this.productsModel;
    data['products_image'] = this.productsImage;
    data['products_video_link'] = this.productsVideoLink;
    data['products_price'] = this.productsPrice;
    data['products_date_added'] = this.productsDateAdded;
    data['products_last_modified'] = this.productsLastModified;
    data['products_date_available'] = this.productsDateAvailable;
    data['products_weight'] = this.productsWeight;
    data['products_weight_unit'] = this.productsWeightUnit;
    data['products_status'] = this.productsStatus;
    data['is_current'] = this.isCurrent;
    data['products_tax_class_id'] = this.productsTaxClassId;
    data['manufacturers_id'] = this.manufacturersId;
    data['products_ordered'] = this.productsOrdered;
    data['products_liked'] = this.productsLiked;
    data['low_limit'] = this.lowLimit;
    data['is_feature'] = this.isFeature;
    data['products_slug'] = this.productsSlug;
    data['products_type'] = this.productsType;
    data['products_min_order'] = this.productsMinOrder;
    data['products_max_stock'] = this.productsMaxStock;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['currency'] = this.currency;
    data['id'] = this.id;
    data['language_id'] = this.languageId;
    data['products_name'] = this.productsName;
    data['products_description'] = this.productsDescription;
    data['products_url'] = this.productsUrl;
    data['products_viewed'] = this.productsViewed;
    data['products_left_banner'] = this.productsLeftBanner;
    data['products_left_banner_start_date'] = this.productsLeftBannerStartDate;
    data['products_left_banner_expire_date'] =
        this.productsLeftBannerExpireDate;
    data['products_right_banner'] = this.productsRightBanner;
    data['products_right_banner_start_date'] =
        this.productsRightBannerStartDate;
    data['products_right_banner_expire_date'] =
        this.productsRightBannerExpireDate;
    data['manufacturer_name'] = this.manufacturerName;
    data['manufacturer_image'] = this.manufacturerImage;
    data['manufacturers_slug'] = this.manufacturersSlug;
    data['date_added'] = this.dateAdded;
    data['last_modified'] = this.lastModified;
    data['manufacturers_image'] = this.manufacturersImage;
    data['manufacturers_url'] = this.manufacturersUrl;
    data['discount_price'] = this.discountPrice;
    if (this.images != String) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.categories != String) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    data['rating'] = this.rating;
    data['total_user_rated'] = this.totalUserRated;
    data['five_ratio'] = this.fiveRatio;
    data['four_ratio'] = this.fourRatio;
    data['three_ratio'] = this.threeRatio;
    data['two_ratio'] = this.twoRatio;
    data['one_ratio'] = this.oneRatio;
    if (this.reviewedCustomers != String) {
      data['reviewed_customers'] =
          this.reviewedCustomers.map((v) => v.toJson()).toList();
    }
    data['defaultStock'] = this.defaultStock;
    data['isLiked'] = this.isLiked;
    if (this.attributes != String) {
      data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
