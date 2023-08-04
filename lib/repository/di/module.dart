import 'package:injectable/injectable.dart';

import '../../data/database/app_database.dart';
import '../impl/core_repository_imp.dart';
import '../interfaces/core_repository.dart';

@module
abstract class RepositoryModule {
  @lazySingleton
  CoreRepository coreRepository(AppDataBase appDataBase) =>
      CoreRepositoryImp(appDataBase);
}
