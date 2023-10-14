import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc/enums/local_storage_key.dart';

abstract class Preferences {
  static SharedPreferences? _preferences;

  static Future<SharedPreferences> getInstance() async {
    if (_preferences != null) {
      return _preferences!;
    }

    _preferences = await SharedPreferences.getInstance();
    return _preferences!;
  }

  Future<String?> getString(LocalStorageKey key) async {
    SharedPreferences preferences = await getInstance();
    return preferences.getString(key.value);
  }

  Future<void> saveString(LocalStorageKey key, String value) async {
    SharedPreferences preferences = await getInstance();
    preferences.setString(key.value, value);
  }

  Future<int?> getInt(LocalStorageKey key) async {
    SharedPreferences preferences = await getInstance();
    return preferences.getInt(key.value);
  }

  Future<void> saveInt(LocalStorageKey key, int value) async {
    SharedPreferences preferences = await getInstance();
    preferences.setInt(key.value, value);
  }

  Future<bool?> getBool(LocalStorageKey key) async {
    SharedPreferences preferences = await getInstance();
    return preferences.getBool(key.value);
  }

  Future<void> saveBool(LocalStorageKey key, bool value) async {
    SharedPreferences preferences = await getInstance();
    preferences.setBool(key.value, value);
  }

  Future<double?> getDouble(LocalStorageKey key) async {
    SharedPreferences preferences = await getInstance();
    return preferences.getDouble(key.value);
  }

  Future<void> saveDouble(LocalStorageKey key, double value) async {
    SharedPreferences preferences = await getInstance();
    preferences.setDouble(key.value, value);
  }

  Future<List<String>?> getStringList(LocalStorageKey key) async {
    SharedPreferences preferences = await getInstance();
    return preferences.getStringList(key.value);
  }

  Future<void> saveStringList(LocalStorageKey key, List<String> value) async {
    SharedPreferences preferences = await getInstance();
    preferences.setStringList(key.value, value);
  }

  Future<void> delete(LocalStorageKey key) async {
    SharedPreferences preferences = await getInstance();
    preferences.remove(key.value);
  }
}
