class Values {
  String value;
  int valueId;

  Values({this.value, this.valueId});

  Values.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    valueId = json['value_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['value_id'] = this.valueId;
    return data;
  }
}