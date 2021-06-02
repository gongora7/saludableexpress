import 'package:equatable/equatable.dart';
import 'package:flutter_app1/src/api/responses/orders_response.dart';
import 'package:flutter_app1/src/repositories/orders_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_orders_event.dart';

part 'my_orders_state.dart';

class MyOrdersBloc extends Bloc<MyOrderEvent, MyOrdersState> {

  final OrdersRepo ordersRepo;

  MyOrdersBloc(this.ordersRepo) : super(MyOrdersInitial());

  @override
  Stream<MyOrdersState> mapEventToState(MyOrderEvent event) async* {
    if (event is GetOrders) {
      try {
        final ordersResponse = await ordersRepo.fetchOrders();
        if (ordersResponse.success == "1" && ordersResponse.data.isNotEmpty)
          yield MyOrdersLoaded(ordersResponse);
        else
          yield MyOrdersError(ordersResponse.message);
      } on Error {
        yield MyOrdersError("Couldn't fetch weather. Is the device online?");
      }
    }
  }

}