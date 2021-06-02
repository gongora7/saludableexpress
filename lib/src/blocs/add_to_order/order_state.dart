import 'package:equatable/equatable.dart';
import 'package:flutter_app1/src/api/responses/att_to_order_response.dart';

abstract class OrderState extends Equatable {
  const OrderState();
}

class PlaceOrderInitial extends OrderState {
  const PlaceOrderInitial();

  @override
  List<Object> get props => [];
}

class PlaceOrderLoading extends OrderState {
  const PlaceOrderLoading();

  @override
  List<Object> get props => [];
}

class PlaceOrderLoaded extends OrderState {
  final AddToOrderResponse addToOrderResponse;

  const PlaceOrderLoaded(this.addToOrderResponse);

  @override
  List<Object> get props => [this.addToOrderResponse];
}

class PlaceOrderError extends OrderState {
  final String error;

  const PlaceOrderError(this.error);

  @override
  List<Object> get props => [this.error];
}
