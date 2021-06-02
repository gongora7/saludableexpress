import 'package:flutter_app1/src/api/api_provider.dart';
import 'package:flutter_app1/src/api/responses/news_response.dart';

abstract class NewsRepo {
  Future<NewsResponse> fetchNews(int pageNumber,
  int isFeatured, int categoryId);
}

class RealNewsRepo implements NewsRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<NewsResponse> fetchNews(int pageNumber, int isFeatured, int categoryId) {
    return _apiProvider.getNews(pageNumber,
      isFeatured,
      categoryId);
  }
}

class FakeNewsRepo implements NewsRepo {
  @override
  Future<NewsResponse> fetchNews(int pageNumber, int isFeatured, int categoryId) {
    throw UnimplementedError();
  }
}