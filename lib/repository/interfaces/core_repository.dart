abstract class CoreRepository {
  Future<void> saveLangToLocal(String langCode);

  Future<void> saveTokenToLocal(String token);

  Future<String?> getLangFromLocal();

  Future<String?> getTokenFromLocal();

  Future<String?> getDeviceId();

  Future<void> saveDeviceId(String id);

  Future<void> cleanUserData();
}