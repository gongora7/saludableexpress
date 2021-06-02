import 'package:flutter_app1/src/api/api_provider.dart';
import 'package:flutter_app1/src/api/responses/att_to_order_response.dart';
import 'package:flutter_app1/src/api/responses/payment_methods_response.dart';
import 'package:flutter_app1/src/models/checkout/post_order.dart';

abstract class CheckoutRepo {
  Future<PaymentMethodsResponse> fetchPaymentMethods();

  Future<AddToOrderResponse> placeOrder(PostOrder postOrder);
}

class RealCheckoutRepo extends CheckoutRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<PaymentMethodsResponse> fetchPaymentMethods() {
    return _apiProvider.getPaymentMethods();
  }

  @override
  Future<AddToOrderResponse> placeOrder(PostOrder postOrder) {
    return _apiProvider.addToOrder(postOrder);
  }
}

class FakeCheckoutRepo extends CheckoutRepo {
  @override
  Future<PaymentMethodsResponse> fetchPaymentMethods() {
    throw UnimplementedError();
  }

  @override
  Future<AddToOrderResponse> placeOrder(PostOrder postOrder) {
    throw UnimplementedError();
  }
}
