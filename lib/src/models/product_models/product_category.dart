class ProductCategory {
  int categoriesId;
  String categoriesName;
  String categoriesImage;
  String categoriesIcon;
  int parentId;

  ProductCategory(
      {this.categoriesId,
        this.categoriesName,
        this.categoriesImage,
        this.categoriesIcon,
        this.parentId});

  ProductCategory.fromJson(Map<String, dynamic> json) {
    categoriesId = json['categories_id'];
    categoriesName = json['categories_name'];
    categoriesImage = json['categories_image'];
    categoriesIcon = json['categories_icon'];
    parentId = json['parent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categories_id'] = this.categoriesId;
    data['categories_name'] = this.categoriesName;
    data['categories_image'] = this.categoriesImage;
    data['categories_icon'] = this.categoriesIcon;
    data['parent_id'] = this.parentId;
    return data;
  }
}
