import 'package:flutter_app1/src/api/api_provider.dart';
import 'package:flutter_app1/src/api/responses/like_product_response.dart';
import 'package:flutter_app1/src/api/responses/stock_response.dart';
import 'package:flutter_app1/src/api/responses/filters_response.dart';
import 'package:flutter_app1/src/api/responses/products_response.dart';
import 'package:flutter_app1/src/models/get_stock/get_stock_post.dart';
import 'package:flutter_app1/src/models/product_models/product_post_model.dart';

abstract class ProductsRepo {
  Future<ProductsResponse> fetchProducts(ProductPostModel postModel);

  Future<FiltersResponse> fetchFilters(String categoryID);

  Future<StockResponse> fetchStock(GetStockPost getStockPost);

  Future<LikeProductResponse> likeProduct(int productId);
  Future<LikeProductResponse> unlikeProduct(int productId);
}

class RealProductsRepo implements ProductsRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<ProductsResponse> fetchProducts(ProductPostModel postModel) {
    return _apiProvider.getAllProducts(postModel);
  }

  @override
  Future<FiltersResponse> fetchFilters(String categoryID) {
    return _apiProvider.getFilters(categoryID);
  }

  @override
  Future<StockResponse> fetchStock(GetStockPost getStockPost) {
    return _apiProvider.getStock(getStockPost);
  }

  @override
  Future<LikeProductResponse> likeProduct(int productId) {
    return _apiProvider.likeProduct(productId);
  }

  @override
  Future<LikeProductResponse> unlikeProduct(int productId) {
    return _apiProvider.unlikeProduct(productId);
  }
}

class FakeProductsRepo implements ProductsRepo {
  @override
  Future<ProductsResponse> fetchProducts(ProductPostModel postModel) {
    throw UnimplementedError();
  }

  @override
  Future<FiltersResponse> fetchFilters(String categoryID) {
    throw UnimplementedError();
  }

  @override
  Future<StockResponse> fetchStock(GetStockPost getStockPost) {
    throw UnimplementedError();
  }

  @override
  Future<LikeProductResponse> likeProduct(int productId) {
    throw UnimplementedError();
  }

  @override
  Future<LikeProductResponse> unlikeProduct(int productId) {
    throw UnimplementedError();
  }
}
