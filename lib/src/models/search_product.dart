import 'search_product_category.dart';

class SearchProduct {
  int serverTime;
  int productsId;
  int productsQuantity;
  String productsModel;
  String productsImage;
  String productsVideoLink;
  int productsPrice;
  String productsDateAdded;
  String productsLastModified;
  String productsDateAvailable;
  String productsWeight;
  String productsWeightUnit;
  int productsStatus;
  int isCurrent;
  int productsTaxClassId;
  String manufacturersId;
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
  int id;
  int languageId;
  String productsName;
  String productsDescription;
  String productsUrl;
  int productsViewed;
  String productsLeftBanner;
  var productsLeftBannerStartDate;
  var productsLeftBannerExpireDate;
  String productsRightBanner;
  var productsRightBannerStartDate;
  var productsRightBannerExpireDate;
  String manufacturerName;
  String manufacturerImage;
  String manufacturersSlug;
  String dateAdded;
  String lastModified;
  String manufacturersImage;
  String manufacturersUrl;
  String discountPrice;
  String currency;
  List<SearchProductCategory> categories;
  String rating;
  int totalUserRated;
  int fiveRatio;
  int fourRatio;
  int threeRatio;
  int twoRatio;
  int oneRatio;
  String isLiked;
  int defaultStock;

  SearchProduct(
      {this.serverTime,
        this.productsId,
        this.productsQuantity,
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
        this.currency,
        this.categories,
        this.rating,
        this.totalUserRated,
        this.fiveRatio,
        this.fourRatio,
        this.threeRatio,
        this.twoRatio,
        this.oneRatio,
        this.isLiked,
        this.defaultStock});

  SearchProduct.fromJson(Map<String, dynamic> json) {
    serverTime = json['server_time'];
    productsId = json['products_id'];
    productsQuantity = json['products_quantity'];
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
    currency = json['currency'];
    if (json['categories'] != null) {
      categories = new List<SearchProductCategory>();
      json['categories'].forEach((v) {
        categories.add(new SearchProductCategory.fromJson(v));
      });
    }
    rating = json['rating'];
    totalUserRated = json['total_user_rated'];
    fiveRatio = json['five_ratio'];
    fourRatio = json['four_ratio'];
    threeRatio = json['three_ratio'];
    twoRatio = json['two_ratio'];
    oneRatio = json['one_ratio'];
    isLiked = json['isLiked'];
    defaultStock = json['defaultStock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['server_time'] = this.serverTime;
    data['products_id'] = this.productsId;
    data['products_quantity'] = this.productsQuantity;
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
    data['currency'] = this.currency;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    data['rating'] = this.rating;
    data['total_user_rated'] = this.totalUserRated;
    data['five_ratio'] = this.fiveRatio;
    data['four_ratio'] = this.fourRatio;
    data['three_ratio'] = this.threeRatio;
    data['two_ratio'] = this.twoRatio;
    data['one_ratio'] = this.oneRatio;
    data['isLiked'] = this.isLiked;
    data['defaultStock'] = this.defaultStock;
    return data;
  }
}
