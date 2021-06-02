
class StockResponse {
  String success;
  int stock;
  String message;

  StockResponse({this.success, this.stock, this.message});

  StockResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    stock = json['stock'];
    message = json['message'];
  }

  StockResponse.withError(String error) {
    success = "0";
    stock = -1;
    message = error;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['stock'] = this.stock;
    data['message'] = this.message;
    return data;
  }
}
