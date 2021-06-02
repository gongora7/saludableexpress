import 'package:flutter_app1/src/models/language_data.dart';

class LanguagesResponse {
  String success;
  List<LanguageData> languages;
  String message;

  LanguagesResponse({this.success, this.languages, this.message});

  LanguagesResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['languages'] != null) {
      languages = new List<LanguageData>();
      json['languages'].forEach((v) {
        languages.add(new LanguageData.fromJson(v));
      });
    }
    message = json['message'];
  }

  LanguagesResponse.withError(String error) {
    success = "0";
    languages = null;
    message = error;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.languages != null) {
      data['languages'] = this.languages.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}