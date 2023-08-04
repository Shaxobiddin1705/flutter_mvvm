import 'package:flutter_mvvm/data/network/provider/interfaces/random_user_provider.dart';
import 'package:flutter_mvvm/data/network/response/result.dart';
import 'package:flutter_mvvm/model/random_user/random_user_model.dart';
import 'package:flutter_mvvm/repository/interfaces/random_user_repository.dart';

class RandomUserRepositoryImp extends RandomUserRepository{
  final RandomUserProvider _randomUserProvider;

  RandomUserRepositoryImp(this._randomUserProvider);


  @override
  Future<Result<List<RandomUser>>> fetchRandomUsers() async{
    final clientResult = await _randomUserProvider.fetchRandomUsers();
    if (clientResult.data != null) {
      return toResult2(
        _randomUserProvider.fetchRandomUsers(),
        fromSuccessResponse: (response) => clientResult.data ?? [],
      );
    }
    return Result.error(
      clientResult.errors,
      errorCodes: clientResult.developerMessage,
    );
  }

}