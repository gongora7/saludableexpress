import 'package:flutter_app1/app_data.dart';
import 'package:flutter_app1/src/models/stripe/tarjeta_credito.dart';
import 'package:flutter_app1/src/repositories/checkout_repo.dart';
import 'package:flutter_app1/src/services/stripe_service.dart';
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
        if (event.postOrder.payment_method == "stripe") {
          final stripeService = new StripeService();
          final resp = await stripeService.realizarPago(
            cardNumber: AppData.tarjetaCredito.cardNumber,
            expMonth: "${AppData.tarjetaCredito.expiracyMonth}",
            expYear: "${AppData.tarjetaCredito.expiracyYear}",
            cvv: AppData.tarjetaCredito.cvv,
            amount: '${(event.postOrder.totalPrice * 100).floor()}',
            currency: event.postOrder.currency_code,
          );
          if (resp.status == "succeeded") {
            event.postOrder.payment_sripe = "1";
          } else {
            event.postOrder.payment_sripe = "0";
          }
        } else if (event.postOrder.payment_method == "paytm") {
          final stripeService = new StripeService();
          final resp = await stripeService.realizarPagoOxxo(
            nombre: event.postOrder.customers_name,
            email: event.postOrder.email,
            amount: '${(event.postOrder.totalPrice * 100).floor()}',
            currency: event.postOrder.currency_code,
          );
          if (resp.status == "succeeded") {
            event.postOrder.payment_sripe = "1";
          } else {
            event.postOrder.payment_sripe = "0";
          }
          AppData.comfirmOxxo = resp;
        }
        if (event.postOrder.payment_method != "directbank") {
          AppData.transferBankData = null;
        }
        if (event.postOrder.payment_method != "paytm") {
          AppData.comfirmOxxo = null;
        }
//Realiza pago block
        final addToOrderResponse =
            await checkoutRepo.placeOrder(event.postOrder);
        AppData.tarjetaCredito = null;
        yield PlaceOrderLoaded(addToOrderResponse);
      } on Error {
        yield PlaceOrderError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
