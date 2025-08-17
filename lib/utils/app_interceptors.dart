// import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppInterceptors extends InterceptorsWrapper {
  final logger = Logger(printer: PrettyPrinter());

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      logger.d('REQUEST[${options.method}] => URI: ${options.uri}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      logger.d(
        'RESPONSE[${response.statusCode}] => URI: ${response.requestOptions.uri}',
      );
    }
    // final prettyString = const JsonEncoder.withIndent(
    //   '  ',
    // ).convert(response.data);
    // logger.f(prettyString);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      logger.e(
        'ERROR[${err.response?.statusCode}] => URI: ${err.requestOptions.uri}',
      );
      logger.e('${err.response}');
    }
    super.onError(err, handler);
  }
}
