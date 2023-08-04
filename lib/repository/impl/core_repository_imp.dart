import '../../../data/database/app_database.dart';
import '../interfaces/core_repository.dart';

class CoreRepositoryImp extends CoreRepository {
  final AppDataBase appDataBase;

  CoreRepositoryImp(this.appDataBase);

  @override
  Future<void> saveLangToLocal(String langCode) async {
    await appDataBase.saveLang(langCode);
  }

  @override
  Future<String?> getLangFromLocal() {
    return appDataBase.getLang();
  }

  @override
  Future<String?> getTokenFromLocal() {
    return appDataBase.getToken();
  }

  @override
  Future<void> saveTokenToLocal(String token) {
    return appDataBase.saveToken(token);
  }

  @override
  Future<String?> getDeviceId() {
    return appDataBase.getDeviceId();
  }

  @override
  Future<void> saveDeviceId(String id) {
    return appDataBase.saveDeviceId(id);
  }

  @override
  Future<void> cleanUserData() {
    return appDataBase.cleanUserData();
  }
}
