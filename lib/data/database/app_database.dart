import 'package:flutter_mvvm/data/database/keys/database_keys.dart';
import 'package:hive_flutter/adapters.dart';

abstract class AppDataBase {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(DatabaseKeys.name);
  }

  Future<void> saveLang(String langCode);

  Future<void> saveToken(String token);

  Future<String?> getLang();

  Future<String?> getToken();

  Future<String?> getDeviceId();

  Future<void> saveDeviceId(String id);

  Future<void> cleanUserData();
}
