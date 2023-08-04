import 'dart:async';

import '../data/app_exceptions.dart';
import '../data/network/response/api_response.dart';
import '../data/network/response/result.dart';


abstract class BaseRepository {

  @Deprecated('Use toResult2()')
  Future<Result<DATA>> toResult<DATA, T extends ApiResponse<DATA>>(
      Future<T> future, {
        Future Function(DATA data)? onSuccess,
        Future Function(ApiResponse)? onError,
        Future Function(Object e)? onFailed,
      }) async {
    try {
      final response = await future;
      if (response.success) {
        final data = response.data as DATA;
        await onSuccess?.call(data);
        return Result.completed(data);
      }
      await onError?.call(response);

      final errors = response.errors;

      if (errors is List) {
        return Result.error(
          errorCodesToMessage(errors.cast<String>()),
          errorCodes: List.from(errors),
        );
      } else if (errors is Map<String, dynamic>) {
        final errorMessage = errors['msg'];
        if (errorMessage != null && errorMessage is String) {
          return Result.error(
            errorCodesToMessage([errorMessage]),
            errorCodes: [errorMessage],
          );
        }
      }
      return Result.error(
        response.errors?.toString() ?? 'Something went wrong',
        errorCodes: [response.errors.toString()],
      );
    } catch (e) {
      await onFailed?.call(e);
      return Result.error('Something went wrong');
    }
  }

  String errorCodesToMessage(List<String> errorCodes) {
    // final backendCodes = _backendCodes;
    // if (backendCodes == null) {
    //   return errorCodes.join(', ');
    // }
    // final localizedErrors = errorCodes.map((errorCode) {
    //   final translations = backendCodes[errorCode];
    //   if (translations == null) return errorCode;
    //   return translations[LocaleKeys.lang.tr().toLowerCase()]?.toString() ??
    //       errorCode;
    // });
    // return localizedErrors.join(', ');
    return errorCodes.join(', ');
  }

  String errorCodeToMessage(String errorCode) {
    // final backendCodes = _backendCodes;
    // if (backendCodes == null) {
    //   return errorCode;
    // }
    // final translation = backendCodes[errorCode];
    // if (translation == null) return errorCode;
    // return translation[LocaleKeys.lang.tr().toLowerCase()]?.toString() ??
    //     errorCode;
    return errorCode;
  }

  Future<Result<DATA>> toResult2<DATA, RESPONSE extends ApiResponse>(
      Future<RESPONSE> future, {
        required FutureOr<DATA> Function(RESPONSE response) fromSuccessResponse,
        FutureOr<Result<DATA>> Function(Result<DATA> result)? switchMap,
      }) async {
    try {
      final response = await future;
      if (response.success) {
        final data = await fromSuccessResponse.call(response);
        final result = Result.completed(data);
        return switchMap?.call(result) ?? result;
      }

      final errors = response.errors;

      if (errors is List) {
        final Result<DATA> errorResult = Result.error(
          errorCodesToMessage(errors.cast<String>()),
          errorCodes: List.from(errors),
        );
        return switchMap?.call(errorResult) ?? errorResult;
      } else if (errors is Map<String, dynamic>) {
        final errorMessage = errors['msg'];
        if (errorMessage != null && errorMessage is String) {
          final errorResult = Result<DATA>.error(
            errorCodesToMessage([errorMessage]),
            errorCodes: [errorMessage],
            errorData: errors,
          );
          return switchMap?.call(errorResult) ?? errorResult;
        }
      }

      final errorResult = Result<DATA>.error(
        response.errors?.toString() ?? 'Something went wrong',
        errorCodes: [response.errors.toString()],
      );
      return switchMap?.call(errorResult) ?? errorResult;
    } on RequestCancelled catch (e) {
      final errorResult =
      Result<DATA>.error('Something went wrong', errorData: e);
      return switchMap?.call(errorResult) ?? errorResult;
    } on Exception catch (e) {
      final errorResult =
      Result<DATA>.error('Something went wrong');
      return switchMap?.call(errorResult) ?? errorResult;
    } catch (e) {
      final errorResult =
      Result<DATA>.error('Something went wrong');
      return switchMap?.call(errorResult) ?? errorResult;
    }
  }
}