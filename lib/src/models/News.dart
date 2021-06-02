class News {
  int newsId;
  String newsImage;
  String newsDateAdded;
  String newsLastModified;
  int newsStatus;
  int isFeature;
  String newsSlug;
  String createdAt;
  String updatedAt;
  int languageId;
  String newsName;
  String newsDescription;
  String newsUrl;
  int newsViewed;
  int categoriesId;
  int imageId;

  News(
      {this.newsId,
        this.newsImage,
        this.newsDateAdded,
        this.newsLastModified,
        this.newsStatus,
        this.isFeature,
        this.newsSlug,
        this.createdAt,
        this.updatedAt,
        this.languageId,
        this.newsName,
        this.newsDescription,
        this.newsUrl,
        this.newsViewed,
        this.categoriesId,
        this.imageId});

  News.fromJson(Map<String, dynamic> json) {
    newsId = json['news_id'];
    newsImage = json['news_image'];
    newsDateAdded = json['news_date_added'];
    newsLastModified = json['news_last_modified'];
    newsStatus = json['news_status'];
    isFeature = json['is_feature'];
    newsSlug = json['news_slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    languageId = json['language_id'];
    newsName = json['news_name'];
    newsDescription = json['news_description'];
    newsUrl = json['news_url'];
    newsViewed = json['news_viewed'];
    categoriesId = json['categories_id'];
    imageId = json['image_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['news_id'] = this.newsId;
    data['news_image'] = this.newsImage;
    data['news_date_added'] = this.newsDateAdded;
    data['news_last_modified'] = this.newsLastModified;
    data['news_status'] = this.newsStatus;
    data['is_feature'] = this.isFeature;
    data['news_slug'] = this.newsSlug;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['language_id'] = this.languageId;
    data['news_name'] = this.newsName;
    data['news_description'] = this.newsDescription;
    data['news_url'] = this.newsUrl;
    data['news_viewed'] = this.newsViewed;
    data['categories_id'] = this.categoriesId;
    data['image_id'] = this.imageId;
    return data;
  }
}

