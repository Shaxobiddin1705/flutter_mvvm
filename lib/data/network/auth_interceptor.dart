import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_mvvm/data/network/response/api_response.dart';

import '../database/app_database.dart';

class AuthInterceptor extends InterceptorsWrapper {
  final AppDataBase storage;
  final Dio dio;
  final Dio refreshDio;
  final Function onLogout;

  AuthInterceptor(
      this.storage,
      this.dio,
      this.refreshDio, {
        required this.onLogout,
      });

  bool _isTokenExpired(DateTime expiryDate) {
    final bool isExpired = expiryDate.compareTo(DateTime.now().toUtc()) < 0;
    return isExpired;
  }

  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final token = await storage.getToken();

    if (token != null) {
      // final user = await storage.getPhone();
      // final userId = await storage.getUserId();

      log(token);
      handler.next(
        options
          ..headers[HttpHeaders.authorizationHeader] = 'Bearer $token'
          // ..headers['username'] = user
          // ..headers['userId'] = userId,
      );
    } else {
      handler.next(options);
    }
  }

  int attempt = 0;
  static const int maxAttempts = 3;

  void _resetAttempt() {
    attempt = 0;
  }

  void _incrementAttempt() {
    attempt++;
  }

  @override
  Future<void> onError(DioException e, ErrorInterceptorHandler handler) async {
    // if (e.response?.statusCode == 401 &&
    //     !e.requestOptions.path.contains(UserEndpoints.signOut)) {
    //   final token = await storage.getSessionToken();
    //   final refreshToken = await storage.getRefreshSessionToken();
    //
    //   if (refreshToken != null && token != null) {
    //     final refreshExpiry = await storage.getRefreshTokenExpiryDate();
    //     print('refreshExpiry');
    //     print(refreshExpiry);
    //
    //     final alice = GetIt.I.get<Alice>();
    //
    //     return synchronized(() async {
    //       final sessionTokenExpiry = await storage.getSessionTokenExpiryDate();
    //
    //       print('sessionTokenExpiry $sessionTokenExpiry');
    //       print('now ${DateTime.now().toUtc()}');
    //
    //       if (sessionTokenExpiry == null) {
    //         handler.next(e);
    //         return;
    //       }
    //
    //       if (!_isTokenExpired(sessionTokenExpiry)) {
    //         return _retry(e, handler);
    //       }
    //
    //       try {
    //         if (!_isTokenExpired(refreshExpiry!)) {
    //           print('REFRESH REQUEST');
    //           try {
    //             if (attempt >= maxAttempts) {
    //               // alice.addLog(AliceLog(
    //               //     message: 'max attempt exceeded $attempt $maxAttempts'));
    //               print('max attempt exceeded $attempt $maxAttempts');
    //               handler.next(e);
    //               onLogout.call();
    //               return;
    //             }
    //
    //             _incrementAttempt();
    //             // final refreshResponse = await refreshDio.post(
    //             //   '/ws-user/api/v2/users/tokens/refresh',
    //             //   options: Options(
    //             //     headers: {
    //             //       'Refresh-Token': refreshToken,
    //             //     },
    //             //   ),
    //             // );
    //             print('REFRESH RESPONSE');
    //             print(refreshResponse);
    //
    //             if (refreshResponse.statusCode == 200) {
    //               // final result = ApiResponse.fromJson(
    //               //   refreshResponse.data as Map<String, dynamic>,
    //               //       (data) => RefreshTokenResponse.fromJson(
    //               //     data as Map<String, dynamic>,
    //               //   ),
    //               // );
    //               print('REFRESH RESULT');
    //               print(result);
    //               // await Future.wait([
    //               //   storage.saveSessionToken(result.data!.accessToken),
    //               //   storage.saveRefreshSessionToken(result.data!.refreshToken),
    //               //   storage.saveRefreshTokenExpiryDate(
    //               //     Jwt.getExpiryDate(result.data!.refreshToken)!,
    //               //   ),
    //               //   storage.saveSessionTokenExpiryDate(
    //               //     Jwt.getExpiryDate(result.data!.accessToken)!,
    //               //   ),
    //               // ]);
    //               _resetAttempt();
    //               return _retry(e, handler);
    //             } else if (refreshResponse.statusCode == 401) {
    //               print('refresh failed with 401');
    //               // alice.addLog(AliceLog(message: 'refresh failed with 401'));
    //               onLogout.call();
    //               _resetAttempt();
    //             } else {
    //               handler.next(e);
    //               return;
    //             }
    //           } on DioException catch (e, s) {
    //             print(e);
    //             if (e.response?.statusCode == 401) {
    //               print('onLogout calling with dioError $e');
    //               // alice.addLog(AliceLog(
    //               //     message:
    //               //     'onLogout calling with dioError $e ${e.response?.statusCode}'));
    //               onLogout.call();
    //               _resetAttempt();
    //               return;
    //             } else {
    //               handler.next(e);
    //               return;
    //             }
    //           }
    //         } else {
    //           print('Token expired');
    //           // alice.addLog(AliceLog(message: 'Token expired'));
    //           onLogout.call();
    //           _resetAttempt();
    //           handler.next(e);
    //         }
    //       } catch (ee) {
    //         print(ee);
    //         handler.next(e);
    //       }
    //     });
    //   } else {
    //     handler.next(e);
    //   }
    // } else {
    //   return handler.next(e);
    // }
  }

  Future<void> _retry(DioException e, ErrorInterceptorHandler handler) async {
    // try {
    //   final requestOptions = e.requestOptions;
    //   final data = requestOptions.data;
    //   if (data is FormData) {
    //     final FormData formData = FormData();
    //     formData.fields.addAll(data.fields);
    //     for (final MapEntry<String, MultipartFile> mapFile in data.files) {
    //       final multipartFile = mapFile.value;
    //       String? filePath;
    //       if (multipartFile is MultipartFileExtended) {
    //         filePath = multipartFile.filePath;
    //       }
    //       formData.files.add(
    //         MapEntry(
    //           mapFile.key,
    //           await MultipartFile.fromFile(
    //             filePath ?? multipartFile.filename ?? '',
    //             filename: '${multipartFile.filename}',
    //           ),
    //         ),
    //       );
    //     }
    //     requestOptions.data = formData;
    //   }
    //   final cloneReq = await dio.fetch(requestOptions);
    //   return handler.resolve(cloneReq);
    // } on DioException catch (err) {
    //   return handler.next(err);
    // } catch (_) {
    //   return handler.next(e);
    // }
  }
}