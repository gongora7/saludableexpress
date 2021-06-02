part of 'shipping_methods_bloc.dart';

abstract class ShippingMethodsState extends Equatable {
  const ShippingMethodsState();
}

class ShippingMethodsInitial extends ShippingMethodsState {
  const ShippingMethodsInitial();

  @override
  List<Object> get props => [];
}

class ShippingMethodsLoading extends ShippingMethodsState {
  const ShippingMethodsLoading();

  @override
  List<Object> get props => [];
}

class ShippingMethodsLoaded extends ShippingMethodsState {
  final GetRatesResponse shippingMethodsResponse;

  const ShippingMethodsLoaded(this.shippingMethodsResponse);

  @override
  List<Object> get props => [shippingMethodsResponse];
}

class ShippingMethodsError extends ShippingMethodsState {
  final String error;

  const ShippingMethodsError(this.error);

  @override
  List<Object> get props => [error];
}
