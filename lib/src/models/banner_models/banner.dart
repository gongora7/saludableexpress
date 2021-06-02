class Banner {
  int id;
  String title;
  String url;
  int imageId;
  String image;
  String type;

  Banner({this.id, this.title, this.url, this.imageId, this.image, this.type});

  Banner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    imageId = json['image_id'];
    image = json['image'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['image_id'] = this.imageId;
    data['image'] = this.image;
    data['type'] = this.type;
    return data;
  }
}
