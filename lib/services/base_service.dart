import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class BaseService {
  BaseService({required Dio dio}) : _dio = dio;
  final Dio _dio;

  Future<Response<Map<String, dynamic>>> post(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Options? options,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        url,
        data: data,
        queryParameters: queryParameters,
        options:
            options ??
            Options(
              headers: headers,
              contentType: Headers.formUrlEncodedContentType,
            ),
      );
      return response;
    } on DioException catch (_) {
      throw Exception(
        // AppDioExceptions.fromDioError(dioException: error).errorMessage(),
      );
    }
  }

  Future<Response<Map<String, dynamic>>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        url,
        queryParameters: queryParameters,
        // options: Options(headers: headers),
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (_) {
      throw Exception(
        // AppDioExceptions.fromDioError(dioException: error).errorMessage(),
      );
    }
  }

  Future<Response<Map<String, dynamic>>> put(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Options? options,
  }) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        url,
        data: data,
        queryParameters: queryParameters,
        options:
            options ??
            Options(
              headers: headers,
              contentType: Headers.formUrlEncodedContentType,
            ),
      );
      return response;
    } on DioException catch (_) {
      throw Exception(
        // AppDioExceptions.fromDioError(dioException: error).errorMessage(),
      );
    }
  }
}
