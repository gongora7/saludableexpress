import 'search_product.dart';

class SearchData {
  List<SearchProduct> products;

  SearchData({this.products});

  SearchData.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = new List<SearchProduct>();
      json['products'].forEach((v) {
        products.add(new SearchProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}