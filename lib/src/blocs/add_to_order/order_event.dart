import 'package:equatable/equatable.dart';
import 'package:flutter_app1/src/models/checkout/post_order.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
}

class PlaceOrder extends OrderEvent {
  final PostOrder postOrder;

  const PlaceOrder(this.postOrder);

  @override
  List<Object> get props => [this.postOrder];
}
