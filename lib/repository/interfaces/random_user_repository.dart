import 'package:flutter_mvvm/data/network/response/result.dart';
import 'package:flutter_mvvm/model/random_user/random_user_model.dart';
import 'package:flutter_mvvm/repository/base_repository.dart';

abstract class RandomUserRepository extends BaseRepository{
  Future<Result<List<RandomUser>>> fetchRandomUsers();
}