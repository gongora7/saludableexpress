class UserLikedProducts {
  int productsId;

  UserLikedProducts({this.productsId});

  UserLikedProducts.fromJson(Map<String, dynamic> json) {
    productsId = json['products_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['products_id'] = this.productsId;
    return data;
  }
}