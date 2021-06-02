import 'package:flutter_app1/src/api/api_provider.dart';
import 'package:flutter_app1/src/api/responses/categories_response.dart';

abstract class CategoriesRepo {
  Future<CategoriesResponse> fetchCategories();
}

class RealCategoriesRepo implements CategoriesRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<CategoriesResponse> fetchCategories() {
    return _apiProvider.getCategories();
  }
}

class FakeCategoriesRepo implements CategoriesRepo {
  @override
  Future<CategoriesResponse> fetchCategories() {
    throw UnimplementedError();
  }
}
