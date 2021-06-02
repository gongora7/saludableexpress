import 'package:flutter_app1/src/api/api_provider.dart';
import 'package:flutter_app1/src/api/responses/search_response.dart';

abstract class SearchRepo {
  Future<SearchResponse> fetchSearchData(String query);
}

class RealSearchRepo implements SearchRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<SearchResponse> fetchSearchData(String query) {
    return _apiProvider.processSearch(query);
  }
}

class FakeSearchRepo implements SearchRepo {
  @override
  Future<SearchResponse> fetchSearchData(String query) {
    throw UnimplementedError();
  }
}
