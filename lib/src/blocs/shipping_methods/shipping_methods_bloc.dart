import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app1/src/api/responses/get_rates_response.dart';
import 'package:flutter_app1/src/models/shipping_methods/get_rates_post_model.dart';
import 'package:flutter_app1/src/repositories/shipping_methods_repo.dart';

part 'shipping_methods_event.dart';

part 'shipping_methods_state.dart';

class ShippingMethodsBloc
    extends Bloc<ShippingMethodsEvent, ShippingMethodsState> {
  final ShippingMethodsRepo shippingMethodsRepo;

  ShippingMethodsBloc(this.shippingMethodsRepo)
      : super(ShippingMethodsInitial());

  @override
  Stream<ShippingMethodsState> mapEventToState(
    ShippingMethodsEvent event,
  ) async* {
    yield ShippingMethodsLoading();
    if (event is GetShippingMethods) {
      try {
        final shippingMethodsResponse =
            await shippingMethodsRepo.fetchShippingMethods(event.getRatesPost);
        if (shippingMethodsResponse.success == "1" &&
            shippingMethodsResponse.data != null) {
          yield ShippingMethodsLoaded(shippingMethodsResponse);
        } else
          yield ShippingMethodsError(shippingMethodsResponse.message);
      } on Error {
        yield ShippingMethodsError(
            "Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
