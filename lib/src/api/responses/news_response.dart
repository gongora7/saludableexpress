import 'package:flutter_app1/src/models/News.dart';

class NewsResponse {
  String success;
  List<News> newsData;
  String message;
  int totalRecord;

  NewsResponse({this.success, this.newsData, this.message, this.totalRecord});

  NewsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['news_data'] != null) {
      newsData = new List<News>();
      json['news_data'].forEach((v) {
        newsData.add(new News.fromJson(v));
      });
    }
    message = json['message'];
    totalRecord = json['total_record'];
  }

  NewsResponse.withError(String error) {
    success = "0";
    newsData = null;
    message = error;
    totalRecord = 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.newsData != null) {
      data['news_data'] = this.newsData.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['total_record'] = this.totalRecord;
    return data;
  }
}