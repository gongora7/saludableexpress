class PaymentMethodObj {
  String authToken;
  String clientId;
  String clientSecret;
  String environment;
  String name;
  String publicKey;
  int active;
  String paymentMethod;
  String method;

  PaymentMethodObj(
      {this.authToken,
      this.clientId,
      this.clientSecret,
      this.environment,
      this.name,
      this.publicKey,
      this.active,
      this.paymentMethod,
      this.method});

  PaymentMethodObj.fromJson(Map<String, dynamic> json) {
    authToken = json['auth_token'];
    clientId = json['client_id'];
    clientSecret = json['client_secret'];
    environment = json['environment'];
    name = json['name'];
    publicKey = json['public_key'];
    active = json['active'];
    paymentMethod = json['payment_method'];
    method = json['method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auth_token'] = this.authToken;
    data['client_id'] = this.clientId;
    data['client_secret'] = this.clientSecret;
    data['environment'] = this.environment;
    data['name'] = this.name;
    data['public_key'] = this.publicKey;
    data['active'] = this.active;
    data['payment_method'] = this.paymentMethod;
    data['method'] = this.method;
    return data;
  }
}
