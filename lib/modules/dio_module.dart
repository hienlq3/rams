import 'package:dio/dio.dart';
import 'package:flutter_application_1/utils/app_interceptors.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio dio() {
    final options = BaseOptions(
      baseUrl: 'https://stg-rams-be-dev.joblogicapps.com',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'x-jl-tenant-id': '52642a7d-e51b-47c7-bd95-1bd48966c8c6',
      },
    );

    final dio = Dio(options);

    dio.interceptors.add(AppInterceptors());

    return dio;
  }
}
