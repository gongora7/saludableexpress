class AddAddressResponse {
  String success;
  List<String> data;
  String message;

  AddAddressResponse({this.success, this.data, this.message});

  AddAddressResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'].cast<String>();
    message = json['message'];
  }

  AddAddressResponse.withError(String error) {
    success = "0";
    data = null;
    message = error;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['data'] = this.data;
    data['message'] = this.message;
    return data;
  }
}