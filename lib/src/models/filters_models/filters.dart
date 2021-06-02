import 'option.dart';
import 'values.dart';

class Filters {
  Option option;
  List<Values> values;

  Filters({this.option, this.values});

  Filters.fromJson(Map<String, dynamic> json) {
    option =
        json['option'] != null ? new Option.fromJson(json['option']) : null;
    if (json['values'] != null) {
      values = new List<Values>();
      json['values'].forEach((v) {
        values.add(new Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.option != null) {
      data['option'] = this.option.toJson();
    }
    if (this.values != null) {
      data['values'] = this.values.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
