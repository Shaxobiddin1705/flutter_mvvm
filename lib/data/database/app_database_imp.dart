import 'package:flutter_mvvm/data/database/app_database.dart';
import 'package:flutter_mvvm/data/database/keys/database_keys.dart';
import 'package:hive/hive.dart';

class AppDataBaseImp extends AppDataBase {
  final Box _box;

  AppDataBaseImp(this._box);

  @override
  Future<void> saveLang(String langCode) async {
    await _box.put(DatabaseKeys.lang, langCode);
  }

  @override
  Future<void> saveToken(String token) async {
    return await _box.put(DatabaseKeys.token, token);
  }

  @override
  Future<String?> getLang() async {
    return await _box.get(DatabaseKeys.lang);
  }

  @override
  Future<String?> getToken() async {
    return await _box.get(DatabaseKeys.token);
  }

  @override
  Future<String?> getDeviceId() async {
    return await _box.get(DatabaseKeys.deviceId);
  }

  @override
  Future<void> saveDeviceId(String id) async {
    return await _box.put(DatabaseKeys.deviceId, id);
  }

  @override
  Future<void> cleanUserData() async {
    await _box.delete(DatabaseKeys.token);
  }
}
