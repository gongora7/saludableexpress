
import 'package:flutter_app1/src/api/api_provider.dart';
import 'package:flutter_app1/src/api/responses/orders_response.dart';

abstract class OrdersRepo{
  Future<OrdersResponse> fetchOrders();
}

class RealOrdersRepo implements OrdersRepo {
  ApiProvider _apiProvider = ApiProvider();
  @override
  Future<OrdersResponse> fetchOrders() {
    return _apiProvider.getOrders();
  }

}

class FakeOrdersRepo implements OrdersRepo {
  @override
  Future<OrdersResponse> fetchOrders() {
    throw UnimplementedError();
  }

}