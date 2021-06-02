import 'dart:developer';

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  int _maxCharactersPerLine = 200;

  @override
  Future onRequest(RequestOptions options) {
    print("--> ${options.method} ${options.path}");
    //print("Content type: ${options.contentType}");
    print(options.headers);
    String responseAsString = options.data.toString();
    log(" \n<-- START PARAMS: \n" +
        responseAsString +
        "\nEND PARAMS -->\n<-- END HTTP");
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    print(
        "<-- ${response.statusCode} ${response.request.method} ${response.request.path}");
    String responseAsString = response.data.toString();
    log(" \n<-- START RESPONSE: \n" +
        responseAsString +
        "\nEND RESPONSE -->\n<-- END HTTP");
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    print("<-- Error -->");
    print(err.error);
    print(err.message);
    return super.onError(err);
  }
}
