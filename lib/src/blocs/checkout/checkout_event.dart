import 'package:equatable/equatable.dart';
import 'package:flutter_app1/src/models/checkout/post_order.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();
}

class GetPaymentMethods extends CheckoutEvent {
  const GetPaymentMethods();

  @override
  List<Object> get props => [];
}
