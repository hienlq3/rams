// import 'package:dio/dio.dart';
// import 'package:wp_core/src/models/base_response_model.dart';

// class AppDioExceptions implements Exception {
//   static late String message;
//   static int statusCode = -1;

//   AppDioExceptions.fromDioError({
//     required DioException dioException,
//     String? errorFrom,
//   }) {
//     //This will print error is Json format and colorful
//     // _prettyPrintError(dioException: dioException, errorFrom: errorFrom);
//     switch (dioException.type) {
//       case DioExceptionType.cancel:
//         message = 'Request to API server was cancelled';
//         break;
//       case DioExceptionType.connectionTimeout:
//         message = 'Connection timeout with API server';
//         break;
//       case DioExceptionType.receiveTimeout:
//         message = 'Receive timeout in connection with API server';
//         break;
//       case DioExceptionType.badResponse:
//         message = _handleError(dioException.response?.statusCode, dioException);
//         statusCode = dioException.response?.statusCode ?? -1;
//         break;
//       case DioExceptionType.sendTimeout:
//         message = 'Send timeout in connection with API server';
//         break;
//       case DioExceptionType.connectionError:
//       case DioExceptionType.unknown:
//         if (dioException.message?.isNotEmpty == true) {
//           message = dioException.message ?? '';
//         } else {
//           message =
//               (dioException.error as FormatException?)?.source?.toString() ??
//               'Unexpected error occurred';
//         }
//         break;
//       default:
//         message = 'Something went wrong';
//         break;
//     }
//   }

//   String _handleError(int? statusCode, DioException error) {
//     if (error.response != null) {
//       var errorMessage = '';
//       final errorResponse = BaseResponseModel.fromJson(
//         (error.response?.data as Map<String, dynamic>?) ??
//             const <String, dynamic>{},
//         (p0) => null,
//       );
//       errorMessage = errorResponse.message ?? '';
//       return 'Lỗi API: $errorMessage';
//     } else {
//       return 'Lỗi kết nối: ${error.message}';
//       // switch (statusCode) {
//       //   case 400:
//       //     return 'Bad request';
//       //   case 401:
//       //     return 'Unauthorized';
//       //   case 403:
//       //     return 'Forbidden';
//       //   case 404:
//       //     return '';
//       //   case 500:
//       //     return 'Internal server error';
//       //   case 502:
//       //     return 'Bad gateway';
//       //   default:
//       //     return 'Oops something went wrong';
//       // }
//     }
//   }

//   String errorMessage() => message;

//   int errorStatusCode() => statusCode;
// }
