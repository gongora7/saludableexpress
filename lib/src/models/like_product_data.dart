class LikeProductData {
  int likedProductsId;

  LikeProductData({this.likedProductsId});

  LikeProductData.fromJson(Map<String, dynamic> json) {
    likedProductsId = json['liked_products_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['liked_products_id'] = this.likedProductsId;
    return data;
  }
}
