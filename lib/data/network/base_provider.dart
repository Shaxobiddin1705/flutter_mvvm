import 'package:dio/dio.dart';

import '../app_exceptions.dart';
import 'response/api_response.dart';

abstract class BaseProvider {

  Future<ApiResponse<T>> apiCall<T>(
      Future<Response> request, {
        required T Function(dynamic data) dataFromJson,
        T? Function(dynamic errorData)? errorDataFromJson,
      }) async {
    try {
      final response = await request;
      return ApiResponse.fromJson(
        response.data as Map<String, dynamic>,
            (data) {
          return dataFromJson(data);
        },
      );
    } on DioException catch (e, s) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionError:
        case DioExceptionType.badCertificate:
          return ApiResponse<T>(
            null,
            success: false,
            errors: [e.message],
            developerMessage: {
              'exception': e,
              'stackTrace': s,
            },
          );
        case DioExceptionType.badResponse:
        case DioExceptionType.unknown:
          if (e.response?.data != null) {
            print(
              'Error data DioErrorType.unknown data not null: $e ${e.response?.data} ${e.error} ${e.stackTrace}',
            );
            try {
              final errorResponse = ApiResponse.fromJson(
                e.response?.data as Map<String, dynamic>,
                    (data) => errorDataFromJson?.call(data),
              );

              return ApiResponse<T>(
                errorResponse.data,
                success: errorResponse.success,
                errors: errorResponse.errors,
                developerMessage: {
                  'exception': e,
                  'stackTrace': s,
                },
              );
            } catch (ee) {
              print(
                'Error data DioErrorType.unknown catch: $e ${e.response?.data} ${e.error} ${e.stackTrace}',
              );
              print(
                'Error data DioErrorType.unknown catch: $ee',
              );
              return ApiResponse(
                null,
                success: false,
                errors: ['Error code: ${e.response?.statusCode}'],
              );
            }
          }
          print(
            'Error data DioErrorType.unknown: $e ${e.response?.data} ${e.error} ${e.stackTrace}',
          );
          return ApiResponse(
            null,
            success: false,
            errors: ['Error code: ${e.response?.statusCode}'],
          );
        case DioExceptionType.cancel:
          throw RequestCancelled(e.message);
      }
    } on RequestCancelled {
      rethrow;
    } on Exception catch (e, s) {
      return ApiResponse<T>(
        null,
        errors: ['Something went wrong'],
        success: false,
        developerMessage: {
          'exception': e,
          'stackTrace': s,
        },
      );
    }
  }
}
