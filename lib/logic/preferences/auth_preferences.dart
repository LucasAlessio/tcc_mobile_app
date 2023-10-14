import 'package:tcc/enums/local_storage_key.dart';
import 'package:tcc/logic/preferences/preferences.dart';
import 'package:tcc/models/user.dart';

class AuthPreferences extends Preferences {
  Future<String> getToken() async {
    String token = await getString(LocalStorageKey.accessToken) ?? "";
    return token;
  }

  void saveAuthData({
    required User user,
  }) async {
    await saveString(LocalStorageKey.accessToken, user.token);
    await saveString(LocalStorageKey.expiresAt, user.expiresAt.toString());
  }

  Future<void> deleteAuthData() async {
    await delete(LocalStorageKey.accessToken);
    await delete(LocalStorageKey.expiresAt);
  }

  Future<bool> isAuthExpired() async {
    String expiresAt = await getString(LocalStorageKey.expiresAt) ?? "";

    if (expiresAt.isEmpty) {
      return true;
    }

    DateTime date = DateTime.parse(expiresAt);
    if (DateTime.now().isAfter(date)) {
      deleteAuthData();
      return true;
    }

    return false;
  }
}
