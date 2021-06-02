import 'package:equatable/equatable.dart';
import 'package:flutter_app1/src/api/responses/att_to_order_response.dart';
import 'package:flutter_app1/src/api/responses/payment_methods_response.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();
}

class PaymentMethodsInitial extends CheckoutState {
  const PaymentMethodsInitial();

  @override
  List<Object> get props => [];
}

class PaymentMethodsLoading extends CheckoutState {
  const PaymentMethodsLoading();

  @override
  List<Object> get props => [];
}

class PaymentMethodsLoaded extends CheckoutState {
  final PaymentMethodsResponse paymentMethodsResponse;

  const PaymentMethodsLoaded(this.paymentMethodsResponse);

  @override
  List<Object> get props => [paymentMethodsResponse];
}

class PaymentMethodsError extends CheckoutState {
  final String error;

  const PaymentMethodsError(this.error);

  @override
  List<Object> get props => [error];
}
