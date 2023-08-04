import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_mvvm/data/database/app_database.dart';
import 'package:flutter_mvvm/data/network/endpoints/endpoints.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @singleton
  @Named('base_url')
  String provideBaseUrl() => Endpoint.baseUrl;

  @Named('app_interceptor')
  Interceptor provideAppInterceptor() =>
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final headers = options.headers;
            // ..[HttpHeaders.acceptLanguageHeader] = appDetails.appLang
            // ..['lang'] = appDetails.appLang;
          handler.next(options..headers.addAll(headers));
        },
      );

  @lazySingleton
  Dio dio(
      BaseOptions baseOptions,
      @Named('base_url') String baseUrl,
      @Named('app_interceptor') Interceptor appInterceptor,
      AppDataBase storage,
      ) {
    final dio = Dio(baseOptions..baseUrl = baseUrl);
    final refreshDio = Dio(baseOptions..baseUrl = baseUrl)
      ..interceptors.addAll([
        appInterceptor,
      ]);

    return dio
      ..interceptors.addAll([
        appInterceptor,
        // AuthInterceptorV2(
        //   storage,
        //   dio,
        //   refreshDio,
        //   onLogout: onLogout,
        // ),
        // aliceInterceptor,
        // if (!kReleaseMode)
        //   PrettyDioLogger(
        //     requestHeader: true,
        //     requestBody: true,
        //   ),
      ]);
  }

  // @lazySingleton
  // AliceDioInterceptor provideInterceptor(Alice alice) {
  //   return alice.getDioInterceptor();
  // }

  BaseOptions baseOptions() => BaseOptions(
    sendTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    connectTimeout: const Duration(seconds: 30),
    contentType: Headers.jsonContentType,
    headers: {
      // 'app-version': appDetails.appVersion,
      // 'device-model': appDetails.deviceModel,
      // 'device-type': appDetails.deviceType,
      // 'app-build': appDetails.appBuild,
      // 'device-id': appDetails.deviceId,
    },
  );

  // @lazySingleton
  // InternetConnectionChecker injectInternetConnectionChecker(
  //     @Named('base_url') String baseUrl,
  //     ) {
  //   final uri = Uri.parse(baseUrl);
  //   return InternetConnectionChecker.createInstance(
  //     checkTimeout: const Duration(seconds: 3),
  //     addresses: [
  //       AddressCheckOptions(
  //         port: uri.port,
  //         hostname: uri.host,
  //       ),
  //     ],
  //   );
  // }
  //
  // @lazySingleton
  // Connectivity injectConnectivity() => Connectivity();
}