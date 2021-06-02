part of 'my_orders_bloc.dart';

abstract class MyOrderEvent extends Equatable {
  const MyOrderEvent();
}

class GetOrders extends MyOrderEvent {
  const GetOrders();

  @override
  List<Object> get props => [];
}
