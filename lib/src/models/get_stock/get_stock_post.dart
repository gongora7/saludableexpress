class GetStockPost {
  int productsId;
  List<String> attributes;

  GetStockPost(this.productsId, this.attributes);

  GetStockPost.fromJson(Map<String, dynamic> json) {
    productsId = json['products_id'];
    if (json['attributes'] != null) {
      attributes = new List<String>();
      json['attributes'].forEach((v) {
        attributes.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['products_id'] = this.productsId;
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((e) => e).toList();
    }
    return data;
  }
}
