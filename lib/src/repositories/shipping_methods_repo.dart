import 'package:flutter_app1/src/api/api_provider.dart';
import 'package:flutter_app1/src/api/responses/banners_response.dart';
import 'package:flutter_app1/src/api/responses/get_rates_response.dart';
import 'package:flutter_app1/src/models/shipping_methods/get_rates_post_model.dart';

abstract class ShippingMethodsRepo {
  Future<GetRatesResponse> fetchShippingMethods(GetRatesPost getRatesPost);
}

class RealShippingMethodsRepo implements ShippingMethodsRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<GetRatesResponse> fetchShippingMethods(GetRatesPost getRatesPost) {
    return _apiProvider.getRates(getRatesPost);
  }
}

class FakeShippingMethodsRepo implements ShippingMethodsRepo {
  @override
  Future<GetRatesResponse> fetchShippingMethods(GetRatesPost getRatesPost) {
    // TODO: implement fetchBanners
    throw UnimplementedError();
  }
}
