// To parse this JSON data, do
//
//     final newsDetails = newsDetailsFromJson(jsonString);

import 'dart:convert';

NewsDetailsResponse newsDetailsFromJson(String str) =>
    NewsDetailsResponse.fromJson(json.decode(str));

String newsDetailsToJson(NewsDetailsResponse data) => json.encode(data.toJson());

class NewsDetailsResponse {
  NewsDetailsResponse({
    this.newsId,
    this.newsImage,
    this.newsDateAdded,
    this.newsLastModified,
    this.newsStatus,
    this.isFeature,
    this.newsSlug,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.description,
    this.url,
    this.viewed,
    this.imagePath,
  });

  int newsId;
  String newsImage;
  String newsDateAdded;
  dynamic newsLastModified;
  int newsStatus;
  int isFeature;
  String newsSlug;
  DateTime createdAt;
  dynamic updatedAt;
  String name;
  String description;
  String url;
  int viewed;
  String imagePath;

  factory NewsDetailsResponse.fromJson(Map<String, dynamic> json) => NewsDetailsResponse(
        newsId: json["news_id"],
        newsImage: json["news_image"],
        newsDateAdded: json["news_date_added"],
        newsLastModified: json["news_last_modified"],
        newsStatus: json["news_status"],
        isFeature: json["is_feature"],
        newsSlug: json["news_slug"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        name: json["name"],
        description: json["description"],
        url: json["url"],
        viewed: json["viewed"],
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "news_id": newsId,
        "news_image": newsImage,
        "news_date_added": newsDateAdded,
        "news_last_modified": newsLastModified,
        "news_status": newsStatus,
        "is_feature": isFeature,
        "news_slug": newsSlug,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "name": name,
        "description": description,
        "url": url,
        "viewed": viewed,
        "image_path": imagePath,
      };
}
