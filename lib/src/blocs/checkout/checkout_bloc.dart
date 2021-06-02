import 'dart:async';

import 'package:flutter_app1/src/blocs/checkout/checkout_event.dart';
import 'package:flutter_app1/src/blocs/checkout/checkout_state.dart';
import 'package:flutter_app1/src/repositories/checkout_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState>{
  final CheckoutRepo checkoutRepo;

  CheckoutBloc(this.checkoutRepo) : super(PaymentMethodsInitial());

  @override
  Stream<CheckoutState> mapEventToState(CheckoutEvent event) async* {

    if (event is GetPaymentMethods) {
      try {
        final paymentMethodsResponse = await checkoutRepo.fetchPaymentMethods();
        if (paymentMethodsResponse.success == "1" &&
            paymentMethodsResponse.data.isNotEmpty) {
          yield PaymentMethodsLoaded(paymentMethodsResponse);
        } else
          yield PaymentMethodsError(paymentMethodsResponse.message);
      } on Error {
        yield PaymentMethodsError("Couldn't fetch weather. Is the device online?");
      }
    }
  }

}
