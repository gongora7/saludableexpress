class ForgotPasswordResponse {
  String success;
  List<String> data;
  String message;

  ForgotPasswordResponse({this.success, this.data, this.message});

  ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'].cast<String>();
    message = json['message'];
  }

  ForgotPasswordResponse.withError(String error) {
    success = "1";
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