import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  ApiResponse(
      this.data, {
        this.errors,
        required this.success,
        this.developerMessage,
      });

  final T? data;
  final dynamic errors;
  @JsonKey(defaultValue: false)
  final bool success;
  final dynamic developerMessage;

  factory ApiResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? data) fromJsonT,
      ) {
    return _$ApiResponseFromJson<T>(json, fromJsonT);
  }
}