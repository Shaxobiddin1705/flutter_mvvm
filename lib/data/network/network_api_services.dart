import 'dart:convert';
import 'dart:io';

import 'package:flutter_mvvm/data/app_exceptions.dart';
import 'package:flutter_mvvm/data/network/base_api_services.dart';
import 'package:dio/dio.dart';

class NetworkApiServices extends BaseApiServices {
  static const _baseUrl = '';
  static const _requestTimeOut = Duration(seconds: 10);
  static const _responseTimeOut = Duration(seconds: 10);
  static final _baseOption = BaseOptions(
    baseUrl: _baseUrl,
    receiveTimeout: _requestTimeOut,
    connectTimeout: _responseTimeOut,
  );

  final dio = Dio()..options = _baseOption;

  @override
  Future deleteApiResponse(String url, dynamic param) async{
    dynamic responseJson;
    try {
      final response = await dio.delete(url, data: param);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getApiResponse(String url, dynamic param) async {
    dynamic responseJson;
    try {
      final response = await dio.get(url, queryParameters: param);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postApiResponse(String url, dynamic param) async{
    dynamic responseJson;
    try {
      final response = await dio.post(url, data: param);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future putApiResponse(String url, dynamic param) async{
    dynamic responseJson;
    try {
      final response = await dio.put(url, data: param);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.data);
      case 400:
      case 500:
        throw BadRequestException(response.data.toString());
      case 404:
        throw UnauthorizedException(response.data.toString());
      default:
        throw FetchDataException(
            'Error occurred while connecting server with status code ${response.statusCode}');
    }
  }
}
