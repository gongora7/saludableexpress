import 'package:flutter_app1/src/api/api_provider.dart';
import 'package:flutter_app1/src/api/responses/banners_response.dart';

abstract class BannersRepo {
  Future<BannersResponse> fetchBanners();
}

class RealBannersRepo implements BannersRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<BannersResponse> fetchBanners() {
    return _apiProvider.getBanners();
  }
}

class FakeBannersRepo implements BannersRepo {
  @override
  Future<BannersResponse> fetchBanners() {
    throw UnimplementedError();
  }

}
