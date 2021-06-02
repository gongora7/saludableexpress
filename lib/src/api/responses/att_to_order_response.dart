class AddToOrderResponse {
  String success;
  String message;
  String products_id;

  AddToOrderResponse({this.success, this.message, this.products_id});

  AddToOrderResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    products_id = json['products_id'];
  }

  AddToOrderResponse.withError(String error) {
    success = "";
    message = error;
    products_id = "";
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['products_id'] = this.products_id;
    return data;
  }
}
