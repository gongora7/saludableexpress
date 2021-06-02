import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_app1/src/api/responses/filters_response.dart';
import 'package:flutter_app1/src/api/responses/like_product_response.dart';
import 'package:flutter_app1/src/api/responses/products_response.dart';
import 'package:flutter_app1/src/api/responses/stock_response.dart';
import 'package:flutter_app1/src/models/cart_entry.dart';
import 'package:flutter_app1/src/models/get_stock/get_stock_post.dart';
import 'package:flutter_app1/src/models/product_models/product.dart';
import 'package:flutter_app1/src/models/product_models/product_post_model.dart';
import 'package:flutter_app1/src/repositories/products_repo.dart';

part 'products_event.dart';

part 'products_state.dart';

class ProductsBloc {
  final ProductsRepo productsRepo;

  ProductsResponse productsResponse = ProductsResponse();
  FiltersResponse filtersResponse = FiltersResponse();

  List<Product> cartProducts = [];

  final _productsStreamController = StreamController<ProductsResponse>();
  final _productsEventController = StreamController<ProductsEvent>();
  final _filtersStreamController = StreamController<FiltersResponse>();
  final _filtersEventController = StreamController<ProductsEvent>();
  final _cartProductsStreamController = StreamController<List<Product>>();
  final _cartProductsEventController = StreamController<ProductsEvent>();
  final _singleProductStreanController = StreamController<Product>();
  final _singleProductEventController = StreamController<ProductsEvent>();

  final _stockStreamController = StreamController<StockResponse>();
  final _stockEventController = StreamController<ProductsEvent>();

  final _likeStreamController = StreamController<LikeProductResponse>.broadcast();
  final _likeEventController = StreamController<ProductsEvent>();

  StreamSink<ProductsResponse> get products_sink =>
      _productsStreamController.sink;

  Stream<ProductsResponse> get products_stream =>
      _productsStreamController.stream;

  StreamSink<FiltersResponse> get filters_sink => _filtersStreamController.sink;

  Stream<FiltersResponse> get filters_stream => _filtersStreamController.stream;

  StreamSink<List<Product>> get cart_products_sink =>
      _cartProductsStreamController.sink;

  Stream<List<Product>> get cart_product_stream =>
      _cartProductsStreamController.stream;

  StreamSink<Product> get singleProductSink =>
      _singleProductStreanController.sink;

  Stream<Product> get singleProductStream =>
      _singleProductStreanController.stream;

  StreamSink<LikeProductResponse> get likeProductSink => _likeStreamController.sink;
  Stream<LikeProductResponse> get likeProductStream => _likeStreamController.stream;

  Sink<ProductsEvent> get likeEventSink => _likeEventController.sink;

  Sink<ProductsEvent> get products_event_sink => _productsEventController.sink;

  Sink<ProductsEvent> get filters_event_sink => _filtersEventController.sink;

  Sink<ProductsEvent> get cart_products_event_sink =>
      _cartProductsEventController.sink;

  Sink<ProductsEvent> get singleProductEventSink =>
      _singleProductEventController.sink;

  Sink<ProductsEvent> get stock_event_sink => _stockEventController.sink;

  StreamSink<StockResponse> get stock_sink => _stockStreamController.sink;

  Stream<StockResponse> get stock_stream => _stockStreamController.stream;

  ProductsBloc(this.productsRepo) {
    _productsEventController.stream.listen((event) async {
      if (_isDisposed) return;
      if (event is GetProducts) {
        //products_sink.add(ProductsResponse.withError("Error"));
        ProductsResponse data =
            await productsRepo.fetchProducts(event.postModel);
        productsResponse = data;
        if (_isDisposed) return;
        products_sink.add(data);
      } else if (event is GetNextPageProducts) {
        ProductsResponse data =
            await productsRepo.fetchProducts(event.postModel);
        if (data.productData != null && data.productData.length > 0) {
          productsResponse.productData.addAll(data.productData);
          if (_isDisposed) return;
          products_sink.add(productsResponse);
        }
      }
    });

    _filtersEventController.stream.listen((event) async {
      if (event is GetFilters) {
        FiltersResponse data =
            await productsRepo.fetchFilters(event.categoryID);
        filtersResponse = data;
        if (_isDisposed) return;
        filters_sink.add(data);
      }
    });

    _cartProductsEventController.stream.listen((event) async {
      if (event is GetCartProducts) {
        cartProducts = [];
        for (int i = 0; i < event.productsIds.length; i++) {
          ProductPostModel postModel = ProductPostModel();
          postModel.currencyCode = "USD";
          postModel.languageId = 1;
          postModel.productsId = event.productsIds[i].id;

          if (_isDisposed) return;
          ProductsResponse data = await productsRepo.fetchProducts(postModel);
          if (data.success == "1" && data.productData.length > 0) {
            data.productData[0].customerBasketQuantity =
                (event.productsIds[i] as CartEntry).quantity;
            cartProducts.add(data.productData[0]);
          } else {
            cartProducts.add(Product());
          }
        }
        if (_isDisposed) return;
        cart_products_sink.add(cartProducts);
      } else if (event is DeleteCartProduct) {
        cartProducts.removeAt(event.postion);
        cart_products_sink.add(cartProducts);
      } else if (event is IncrementCartProductQuantity) {
        cartProducts[event.position].customerBasketQuantity++;
        cart_products_sink.add(cartProducts);
      } else if (event is DecrementCartProductQuantity) {
        if (cartProducts[event.position].customerBasketQuantity > 1) {
          cartProducts[event.position].customerBasketQuantity--;
          cart_products_sink.add(cartProducts);
        }
      }
    });

    _stockEventController.stream.listen((event) async {
      if (event is GetStock) {
        stock_sink.add(StockResponse.withError("initial"));
        StockResponse data = await productsRepo.fetchStock(event.getStockPost);
        if (_isDisposed) return;
        stock_sink.add(data);
      }
    });

    _singleProductEventController.stream.listen((event) async {
      if (event is GetSingleProduct) {
        ProductPostModel postModel = ProductPostModel();
        postModel.currencyCode = "USD";
        postModel.languageId = 1;
        postModel.productsId = event.productId;

        if (_isDisposed) return;
        ProductsResponse data = await productsRepo.fetchProducts(postModel);
        if (data.success == "1" && data.productData.length > 0) {
          if (_isDisposed) return;
          singleProductSink.add(data.productData[0]);
        } else {
          singleProductSink.add(Product());
        }
      }
    });

    _likeEventController.stream.listen((event) async {
      if (event is LikeProduct){

        if(_isDisposed) return;
        LikeProductResponse data = await productsRepo.likeProduct(event.productId);
        if (data.success == "1" && data.productData.length > 0) {
          if (_isDisposed) return;
          likeProductSink.add(data);
        } else {
          likeProductSink.add(data);
        }
      } else if(event is UnlikeProduct) {
        if(_isDisposed) return;
        LikeProductResponse data = await productsRepo.unlikeProduct(event.productId);
        if (data.success == "1" && data.productData.length > 0) {
          if (_isDisposed) return;
          likeProductSink.add(data);
        } else {
          likeProductSink.add(data);
        }
      }

    });


  }

  bool _isDisposed = false;

  dispose() {
    _productsEventController.close();
    _productsStreamController.close();
    _filtersEventController.close();
    _filtersStreamController.close();
    _cartProductsEventController.close();
    _cartProductsStreamController.close();
    _singleProductStreanController.close();
    _singleProductEventController.close();
    _stockStreamController.close();
    _stockEventController.close();
    _likeStreamController.close();
    _likeEventController.close();
    _isDisposed = true;
  }
}
