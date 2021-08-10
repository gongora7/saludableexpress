import 'dart:developer';

import 'package:dio/dio.dart' as dio;

class LoggingInterceptor extends dio.Interceptor {
  int _maxCharactersPerLine = 200;

  @override
  Future onRequest(
      dio.RequestOptions options, dio.RequestInterceptorHandler handler) {
    print("--> ${options.method} ${options.path}");
    //print("Content type: ${options.contentType}");
    print(options.headers);
    String responseAsString = options.data.toString();
    log(" \n<-- START PARAMS: \n" +
        responseAsString +
        "\nEND PARAMS -->\n<-- END HTTP");
    handler.next(options);
  }

  @override
  Future onResponse(
    dio.Response response,
    dio.ResponseInterceptorHandler handler,
  ) {
    print(
        "<-- ${response.statusCode} ${response.data} ${response.statusMessage}");
    String responseAsString = response.data.toString();
    log(" \n<-- START RESPONSE: \n" +
        responseAsString +
        "\nEND RESPONSE -->\n<-- END HTTP");
    handler.next(response);
  }

  @override
  Future onError(
    dio.DioError err,
    dio.ErrorInterceptorHandler handler,
  ) {
    print("<-- Error -->");
    print(err.error);
    print(err.message);
    handler.next(err);
  }
}
