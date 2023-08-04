import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../app_database.dart';
import '../app_database_imp.dart';
import '../keys/database_keys.dart';

@module
abstract class DataBaseModule {
  @singleton
  AppDataBase appDataBase() => AppDataBaseImp(Hive.box(DatabaseKeys.name));
}
