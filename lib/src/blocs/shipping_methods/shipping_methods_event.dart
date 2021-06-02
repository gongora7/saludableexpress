part of 'shipping_methods_bloc.dart';

abstract class ShippingMethodsEvent extends Equatable {
  const ShippingMethodsEvent();
}

class GetShippingMethods extends ShippingMethodsEvent {
  final GetRatesPost getRatesPost;

  const GetShippingMethods(this.getRatesPost);

  @override
  List<Object> get props => [this.getRatesPost];
}
