import 'package:dio/dio.dart';
import 'package:flutter_mvvm/data/network/provider/impl/random_user_provider_impl.dart';
import 'package:flutter_mvvm/data/network/provider/interfaces/random_user_provider.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ProviderModule {

  RandomUserProvider provideRandomUserProvider(Dio apiClient) =>
      RandomUserProviderImpl(apiClient);
}