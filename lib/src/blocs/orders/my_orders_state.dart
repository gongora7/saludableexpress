part of 'my_orders_bloc.dart';

abstract class MyOrdersState extends Equatable {
  const MyOrdersState();
}

class MyOrdersInitial extends MyOrdersState {
  const MyOrdersInitial();

  @override
  List<Object> get props => [];
}

class MyOrdersLoading extends MyOrdersState {
  const MyOrdersLoading();

  @override
  List<Object> get props => [];
}

class MyOrdersLoaded extends MyOrdersState {
  final OrdersResponse ordersResponse;

  const MyOrdersLoaded(this.ordersResponse);

  @override
  List<Object> get props => [this.ordersResponse];
}

class MyOrdersError extends MyOrdersState {
  final String error;

  const MyOrdersError(this.error);

  @override
  List<Object> get props => [this.error];

}