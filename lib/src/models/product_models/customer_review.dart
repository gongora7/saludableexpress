class CustomerReview {
  int reviewsId;
  int productsId;
  int customersId;
  String customersName;
  int reviewsRating;
  int reviewsStatus;
  int reviewsRead;
  String createdAt;
  String updatedAt;
  String image;

  CustomerReview(
      {this.reviewsId,
        this.productsId,
        this.customersId,
        this.customersName,
        this.reviewsRating,
        this.reviewsStatus,
        this.reviewsRead,
        this.createdAt,
        this.updatedAt,
        this.image});

  CustomerReview.fromJson(Map<String, dynamic> json) {
    reviewsId = json['reviews_id'];
    productsId = json['products_id'];
    customersId = json['customers_id'];
    customersName = json['customers_name'];
    reviewsRating = json['reviews_rating'];
    reviewsStatus = json['reviews_status'];
    reviewsRead = json['reviews_read'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reviews_id'] = this.reviewsId;
    data['products_id'] = this.productsId;
    data['customers_id'] = this.customersId;
    data['customers_name'] = this.customersName;
    data['reviews_rating'] = this.reviewsRating;
    data['reviews_status'] = this.reviewsStatus;
    data['reviews_read'] = this.reviewsRead;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    return data;
  }
}