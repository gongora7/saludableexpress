class Category {
  int categoriesId;
  String categoriesName;
  int parentId;
  String image;
  String icon;
  int totalProducts;

  Category(
      {this.categoriesId,
      this.categoriesName,
      this.parentId,
      this.image,
      this.icon,
      this.totalProducts});

  Category.fromJson(Map<String, dynamic> json) {
    categoriesId = json['categories_id'];
    categoriesName = json['categories_name'];
    parentId = json['parent_id'];
    image = json['image'];
    icon = json['icon'];
    totalProducts = json['total_products'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categories_id'] = this.categoriesId;
    data['categories_name'] = this.categoriesName;
    data['parent_id'] = this.parentId;
    data['image'] = this.image;
    data['icon'] = this.icon;
    data['total_products'] = this.totalProducts;
    return data;
  }
}
