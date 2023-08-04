import 'package:dio/dio.dart';
import 'package:flutter_mvvm/data/network/provider/interfaces/random_user_provider.dart';
import 'package:flutter_mvvm/data/network/response/api_response.dart';
import 'package:flutter_mvvm/model/random_user/random_user_model.dart';

import '../../endpoints/endpoints.dart';

class RandomUserProviderImpl extends RandomUserProvider {
  final Dio apiClient;

  RandomUserProviderImpl(this.apiClient);

  @override
  Future<ApiResponse<List<RandomUser>>> fetchRandomUsers() {
    return apiCall(
      apiClient.get(Endpoint.randomUser),
      dataFromJson: (data) => (data as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map((e) => RandomUser.fromJson(e))
          .toList(),
    );
  }
}
