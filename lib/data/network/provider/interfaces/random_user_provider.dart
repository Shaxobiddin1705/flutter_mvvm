import 'package:flutter_mvvm/data/network/base_provider.dart';
import 'package:flutter_mvvm/model/random_user/random_user_model.dart';

import '../../response/api_response.dart';

abstract class RandomUserProvider extends BaseProvider{
  Future<ApiResponse<List<RandomUser>>> fetchRandomUsers();
}