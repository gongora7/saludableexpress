import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

import 'package:dio/dio.dart';
import 'package:flutter_app1/app_data.dart';
import 'package:flutter_app1/constants.dart';
import 'package:flutter_app1/src/api/responses/add_address_response.dart';
import 'package:flutter_app1/src/api/responses/address_response.dart';
import 'package:flutter_app1/src/api/responses/att_to_order_response.dart';
import 'package:flutter_app1/src/api/responses/countries_response.dart';
import 'package:flutter_app1/src/api/responses/get_rates_response.dart';
import 'package:flutter_app1/src/api/responses/like_product_response.dart';
import 'package:flutter_app1/src/api/responses/news_response.dart';
import 'package:flutter_app1/src/api/responses/orders_response.dart';
import 'package:flutter_app1/src/api/responses/payment_methods_response.dart';
import 'package:flutter_app1/src/api/responses/search_response.dart';
import 'package:flutter_app1/src/api/responses/stock_response.dart';
import 'package:flutter_app1/src/api/responses/banners_response.dart';
import 'package:flutter_app1/src/api/responses/categories_response.dart';
import 'package:flutter_app1/src/api/responses/filters_response.dart';
import 'package:flutter_app1/src/api/responses/zones_response.dart';
import 'package:flutter_app1/src/models/address/address.dart';
import 'package:flutter_app1/src/models/checkout/post_order.dart';
import 'package:flutter_app1/src/models/cupon_response.dart';
import 'package:flutter_app1/src/models/get_stock/get_stock_post.dart';
import 'package:flutter_app1/src/models/product_models/product_post_model.dart';
import 'package:flutter_app1/src/models/shipping_methods/get_rates_post_model.dart';

import 'logging_interceptor.dart';
import 'responses/forgot_password_response.dart';
import 'responses/login_response.dart';
import 'responses/products_response.dart';
import 'responses/settings_response.dart';

class ApiProvider {
  static final String imageBaseUrl = AppConstants.ECOMMERCE_URL;
  final String _baseUrl = AppConstants.ECOMMERCE_URL + "api/";

  Dio _dio;

  ApiProvider() {
    BaseOptions options =
        BaseOptions(receiveTimeout: 15000, connectTimeout: 15000);
    _dio = Dio(options);
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        var customHeaders = {
          'content-type': 'application/json',
          'consumer-key': generateMd5(AppConstants.CONSUMER_KEY),
          'consumer-secret': generateMd5(AppConstants.CONSUMER_SECRET),
          'consumer-nonce': getRandomString(32),
          'consumer-device-id': '516598gtv5b346byrj5af1',
          'consumer-ip': '192.168.1.1'
        };
        options.headers.addAll(customHeaders);
        handler.next(options);
        return options;
      },
    ));
    _dio.interceptors.add(LoggingInterceptor());
  }

  Future<SettingsResponse> getSettings() async {
    try {
      Response response = await _dio.get(_baseUrl + "sitesetting");
      return SettingsResponse.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return SettingsResponse.withError(_handleError(error));
    }
  }

  Future<CategoriesResponse> getCategories() async {
    try {
      Response response = await _dio.post(
        _baseUrl + "allcategories",
        data: jsonEncode({"language_id": "1"}),
      );
      return CategoriesResponse.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CategoriesResponse.withError(_handleError(error));
    }
  }

  Future<BannersResponse> getBanners() async {
    try {
      Response response =
          await _dio.get(_baseUrl + "getbanners?languages_id=" + "1");
      return BannersResponse.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BannersResponse.withError(_handleError(error));
    }
  }

  Future<ProductsResponse> getAllProducts(ProductPostModel postModel) async {
    try {
      Response response = await _dio.post(
        _baseUrl + "getallproducts",
        data: jsonEncode(postModel.toJson()),
      );
      return ProductsResponse.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ProductsResponse.withError(_handleError(error));
    }
  }

  Future<FiltersResponse> getFilters(String categoryID) async {
    try {
      Response response = await _dio.post(
        _baseUrl + "getfilters",
        data: jsonEncode({"language_id": "1", "categories_id": categoryID}),
      );
      return FiltersResponse.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return FiltersResponse.withError(_handleError(error));
    }
  }

  Future<StockResponse> getStock(GetStockPost getStockPost) async {
    try {
      Response response = await _dio.post(_baseUrl + "getquantity",
          data: jsonEncode(getStockPost.toJson()));
      print(jsonEncode(getStockPost.toJson()));
      return StockResponse.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return StockResponse.withError(_handleError(error));
    }
  }

  Future<CountriesResponse> getCountries() async {
    try {
      Response response = await _dio.post(_baseUrl + "getcountries");
      return CountriesResponse.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CountriesResponse.withError(_handleError(error));
    }
  }

  Future<ZonesResponse> getZones(int countryId) async {
    try {
      Response response = await _dio.post(
        _baseUrl + "getzones",
        data: jsonEncode({"zone_country_id": countryId}),
      );
      return ZonesResponse.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ZonesResponse.withError(_handleError(error));
    }
  }

  Future<GetRatesResponse> getRates(GetRatesPost getRatesPost) async {
    try {
      Response response = await _dio.post(
        _baseUrl + "getrate",
        data: jsonEncode(getRatesPost.toJson()),
      );
      return GetRatesResponse.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GetRatesResponse.withError(_handleError(error));
    }
  }

  Future<PaymentMethodsResponse> getPaymentMethods() async {
    try {
      Response response = await _dio.post(
        _baseUrl + "getpaymentmethods",
        data: jsonEncode({"language_id": "1"}),
      );
      return PaymentMethodsResponse.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PaymentMethodsResponse.withError(_handleError(error));
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount':
            amount, // amount charged will be specified when the method is called
        'currency': 'MXN', // the currency
        'payment_method_types[]': 'card' //card
      };
      Response response = await _dio.post(_baseUrl + "paymentIntent", //api url
          data: jsonEncode(body));
      return jsonDecode(response.data); //decode the response to json
    } catch (error) {
      print('Error occured : ${error.toString()}');
    }
    return null;
  }

  Future<AddToOrderResponse> addToOrder(PostOrder postOrder) async {
    try {
      Response response = await _dio.post(
        _baseUrl + "addtoorder",
        data: jsonEncode(postOrder.toJson()),
      );
      return AddToOrderResponse.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return AddToOrderResponse.withError(_handleError(error));
    }
  }

  Future<LoginResponse> processLogin(String email, String password) async {
    try {
      Response response = await _dio.post(
        _baseUrl + "processlogin",
        data: jsonEncode({"email": email, "password": password}),
      );
      return LoginResponse.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return LoginResponse.withError(error);
    }
  }

  Future<LoginResponse> processLoginWithGoogle(
      String idToken,
      String customerId,
      String givenName,
      String familyName,
      String email,
      String imageUrl) async {
    try {
      Response response = await _dio.post(
        _baseUrl + "googleregistration",
        data: jsonEncode({
          "idToken": idToken,
          "customers_id": customerId,
          "givenName": givenName,
          "familyName": familyName,
          "email": email,
          "imageUrl": imageUrl
        }),
      );
      return LoginResponse.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return LoginResponse.withError(error);
    }
  }

  Future<LoginResponse> processLoginWithFacebook(String accessToken) async {
    try {
      Response response = await _dio.post(
        _baseUrl + "facebookregistration",
        data: jsonEncode({"access_token": accessToken}),
      );
      return LoginResponse.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return LoginResponse.withError(error);
    }
  }

  Future<LoginResponse> processLoginWithApple(String accessToken) async {
    try {
      Response response = await _dio.post(
        _baseUrl + "/apple/login",
        data: jsonEncode({"id_token": accessToken}),
      );
      return LoginResponse.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return LoginResponse.withError(error);
    }
  }

  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    try {
      Response response = await _dio.post(
        _baseUrl + "processforgotpassword",
        data: jsonEncode({"email": email}),
      );
      return ForgotPasswordResponse.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ForgotPasswordResponse.withError(error);
    }
  }

  Future<LoginResponse> processRegistration(String firstName, String lastName,
      String email, String password, String countryCode, String phone) async {
    try {
      Response response = await _dio.post(
        _baseUrl + "processregistration",
        data: jsonEncode({
          "customers_firstname": firstName,
          "customers_lastname": lastName,
          "email": email,
          "password": password,
          "country_code": countryCode,
          "customers_telephone": phone
        }),
      );
      return LoginResponse.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return LoginResponse.withError(error);
    }
  }

  Future<SearchResponse> processSearch(String query) async {
    try {
      Response response = await _dio.post(
        _baseUrl + "getsearchdata",
        data: jsonEncode({
          "searchValue": query,
          "language_id": 1,
          "currency_code": "MXN",
        }),
      );
      return SearchResponse.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return SearchResponse.withError(error);
    }
  }

  Future<OrdersResponse> getOrders() async {
    try {
      Response response = await _dio.post(
        _baseUrl + "getorders",
        data: jsonEncode({
          "customers_id": AppData.user != null ? AppData.user.id : "",
          "language_id": 1,
          "currency_code": "MXN",
        }),
      );
      return OrdersResponse.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return OrdersResponse.withError(error);
    }
  }

  Future<AddressResponse> getAllAddresses() async {
    try {
      Response response = await _dio.post(
        _baseUrl + "getalladdress",
        data: jsonEncode(
            {"customers_id": AppData.user != null ? AppData.user.id : ""}),
      );
      return AddressResponse.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return AddressResponse.withError(error);
    }
  }

  Future<AddAddressResponse> addAddress(Address address) async {
    try {
      Response response = await _dio.post(
        _baseUrl + "addshippingaddress",
        data: jsonEncode({
          "customers_id": AppData.user != null ? AppData.user.id : "",
          "entry_firstname": address.deliveryFirstName,
          "entry_lastname": address.deliveryLastName,
          "entry_street_address": address.deliveryStreetAddress,
          "entry_postcode": address.deliveryPostCode,
          "entry_city": address.deliveryCity,
          "entry_country_id": address.deliveryCountry.countriesId,
          "entry_zone_id": address.deliveryZone.zoneId,
          "is_default": 1
        }),
      );
      return AddAddressResponse.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return AddAddressResponse.withError(error);
    }
  }

  Future<LikeProductResponse> likeProduct(int productId) async {
    try {
      Response response = await _dio.post(
        _baseUrl + "likeproduct",
        data: jsonEncode({
          "liked_customers_id": AppData.user != null ? AppData.user.id : "",
          "liked_products_id": productId,
        }),
      );
      return LikeProductResponse.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return LikeProductResponse.withError(error);
    }
  }

  Future<LikeProductResponse> unlikeProduct(int productId) async {
    try {
      Response response = await _dio.post(
        _baseUrl + "unlikeproduct",
        data: jsonEncode({
          "liked_customers_id": AppData.user != null ? AppData.user.id : "",
          "liked_products_id": productId,
        }),
      );
      return LikeProductResponse.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return LikeProductResponse.withError(error);
    }
  }

  Future<NewsResponse> getNews(
      int pageNumber, int isFeatured, int categoryId) async {
    try {
      Response response = await _dio.post(
        _baseUrl + "getallnews",
        data: jsonEncode({
          "language_id": "1",
          "page_number": pageNumber,
          "is_feature": isFeatured,
          "categories_id": categoryId
        }),
      );
      return NewsResponse.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return NewsResponse.withError(error);
    }
  }

  String _handleError(Error error) {
    String errorDescription = "";
    if (error is DioError) {
      DioError dioError = error as DioError;
      switch (dioError.type) {
        case DioErrorType.cancel:
          errorDescription =
              "=======Request to API server was cancelled===========";
          break;
        case DioErrorType.connectTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.other:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.response:
          errorDescription =
              "Received invalid status code: ${dioError.response.statusCode}";
          break;
        case DioErrorType.sendTimeout:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }

  String getRandomString(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(
          _rnd.nextInt(_chars.length),
        ),
      ),
    );
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  Future<CuponResponse> getDescuento(String cupon) async {
    try {
      Response response = await _dio.post(
        _baseUrl + "getcoupon",
        data: jsonEncode({"code": "$cupon"}),
      );
      return cuponResponseFromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CuponResponse(success: "0");
    }
  }
}
