import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter_mvvm/repository/interfaces/core_repository.dart';
import 'package:logger/logger.dart';

class CustomInterceptor extends dio.Interceptor {
  final Logger _logger;
  final CoreRepository _coreRepository;

  CustomInterceptor(this._logger, this._coreRepository);

  @override
  void onResponse(dio.Response response, ResponseInterceptorHandler handler) {
    // ignore: prefer_interpolation_to_compose_strings
    _logger.i("RESPONSE >>>> " +
        response.requestOptions.uri.toString() +
        "\n headers : " +
        response.requestOptions.headers.values.toString() +
        "\n body : " +
        (response.data).toString() +
        "\n param : " +
        response.requestOptions.queryParameters.toString());

    handler.next(response);
  }

  @override
  void onRequest(
      dio.RequestOptions options, dio.RequestInterceptorHandler handler) async {
    final token = await _coreRepository.getTokenFromLocal();
    final lang = await _coreRepository.getTokenFromLocal();
    options.headers['Authorization'] = 'Bearer $token';
    options.headers['language'] = lang;
    // ignore: prefer_interpolation_to_compose_strings
    _logger.d("REQUEST >>>> " +
        options.uri.toString() +
        "\n headers : " +
        options.headers.values.toString() +
        "\n body : " +
        ((options.data is FormData)
                ? (options.data as FormData).fields
                : options.data)
            .toString() +
        "\n param : " +
        options.queryParameters.toString());
    handler.next(options);
  }

  @override
  Future onError(
      dio.DioException err, dio.ErrorInterceptorHandler handler) async {
    _logger.e(
      "ERROR >>>>"
      " ${err.requestOptions.uri}"
      "\n headers : ${err.requestOptions.headers}"
      "\n body : ${err.response?.data}"
      "\n error : ${err.error}",
      error: err.message,
    );

    return handler.next(err);
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
