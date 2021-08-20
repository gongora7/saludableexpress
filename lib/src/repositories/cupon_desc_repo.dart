import 'package:flutter_app1/src/api/api_provider.dart';
import 'package:flutter_app1/src/models/cupon_response.dart';

abstract class CuponDescRepo {
  Future<CuponResponse> getDescuento(String cupon);
}

class RealCuponDescRepo extends CuponDescRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<CuponResponse> getDescuento(String cupon) async {
    return await _apiProvider.getDescuento(cupon);
  }
}