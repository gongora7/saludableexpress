import 'package:flutter_app1/src/repositories/checkout_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final CheckoutRepo checkoutRepo;

  OrderBloc(this.checkoutRepo) : super(PlaceOrderInitial());

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is PlaceOrder) {
      yield PlaceOrderLoading();
      try {
        final addToOrderResponse =
            await checkoutRepo.placeOrder(event.postOrder);
          yield PlaceOrderLoaded(addToOrderResponse);
      } on Error {
        yield PlaceOrderError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
