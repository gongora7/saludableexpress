class LanguageData {
  int languagesId;
  String name;
  String code;
  String image;
  String directory;
  int sortOrder;
  String direction;
  int status;
  int isDefault;

  LanguageData(
      {this.languagesId,
        this.name,
        this.code,
        this.image,
        this.directory,
        this.sortOrder,
        this.direction,
        this.status,
        this.isDefault});

  LanguageData.fromJson(Map<String, dynamic> json) {
    languagesId = json['languages_id'];
    name = json['name'];
    code = json['code'];
    image = json['image'];
    directory = json['directory'];
    sortOrder = json['sort_order'];
    direction = json['direction'];
    status = json['status'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['languages_id'] = this.languagesId;
    data['name'] = this.name;
    data['code'] = this.code;
    data['image'] = this.image;
    data['directory'] = this.directory;
    data['sort_order'] = this.sortOrder;
    data['direction'] = this.direction;
    data['status'] = this.status;
    data['is_default'] = this.isDefault;
    return data;
  }
}