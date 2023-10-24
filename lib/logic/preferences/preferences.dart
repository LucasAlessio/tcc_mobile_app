import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc/enums/local_storage_key.dart';

abstract class Preferences {
  static SharedPreferences? _preferences;

  static Future<SharedPreferences> _getInstance() async {
    if (_preferences != null) {
      return _preferences!;
    }

    _preferences = await SharedPreferences.getInstance();
    return _preferences!;
  }

  Future<void> reload() async {
    SharedPreferences preferences = await _getInstance();
    await preferences.reload();
  }

  Future<String?> getString(LocalStorageKey key) async {
    SharedPreferences preferences = await _getInstance();
    return preferences.getString(key.value);
  }

  Future<bool> saveString(LocalStorageKey key, String value) async {
    SharedPreferences preferences = await _getInstance();
    return await preferences.setString(key.value, value);
  }

  Future<int?> getInt(LocalStorageKey key) async {
    SharedPreferences preferences = await _getInstance();
    return preferences.getInt(key.value);
  }

  Future<bool> saveInt(LocalStorageKey key, int value) async {
    SharedPreferences preferences = await _getInstance();
    return await preferences.setInt(key.value, value);
  }

  Future<bool?> getBool(LocalStorageKey key) async {
    SharedPreferences preferences = await _getInstance();
    return preferences.getBool(key.value);
  }

  Future<bool> saveBool(LocalStorageKey key, bool value) async {
    SharedPreferences preferences = await _getInstance();
    return await preferences.setBool(key.value, value);
  }

  Future<double?> getDouble(LocalStorageKey key) async {
    SharedPreferences preferences = await _getInstance();
    return preferences.getDouble(key.value);
  }

  Future<bool> saveDouble(LocalStorageKey key, double value) async {
    SharedPreferences preferences = await _getInstance();
    return await preferences.setDouble(key.value, value);
  }

  Future<List<String>?> getStringList(LocalStorageKey key) async {
    SharedPreferences preferences = await _getInstance();
    return preferences.getStringList(key.value);
  }

  Future<bool> saveStringList(LocalStorageKey key, List<String> value) async {
    SharedPreferences preferences = await _getInstance();
    return await preferences.setStringList(key.value, value);
  }

  Future<void> delete(LocalStorageKey key) async {
    SharedPreferences preferences = await _getInstance();
    await preferences.remove(key.value);
  }
}
