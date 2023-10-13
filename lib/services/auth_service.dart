import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc/enums/local_storage_key.dart';
import 'package:tcc/services/web_client.dart';

class AuthService {
  String url = WebClient.url;
  http.Client client = WebClient.client;
  http.Client unauthorizedClient = WebClient.unauthorizedClient;

  Future<void> login({required Map<String, dynamic> data}) async {
    Map<String, dynamic> body = {
      ...data,
      'device_name': await _getDeviceName(),
    };

    http.Response response = await unauthorizedClient.post(
      Uri.parse("${url}login"),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(body),
    );

    Map<String, dynamic> r = json.decode(response.body);
    await _saveUserInfo(r);
  }

  Future<void> register({required Map<String, dynamic> data}) async {
    Map<String, dynamic> body = {
      ...data,
      'device_name': await _getDeviceName(),
    };

    http.Response response = await unauthorizedClient.post(
      Uri.parse("${url}register"),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(body),
    );

    Map<String, dynamic> r = json.decode(response.body);
    await _saveUserInfo(r);
  }

  Future<void> logout({required String token}) async {
    await client.post(
      Uri.parse("${url}logout"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    await _deleteUserInfo();
  }

  Future<Map<String, dynamic>> getProfile({required String token}) async {
    http.Response response = await client.get(
      Uri.parse("${url}profile"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    return json.decode(response.body);
  }

  Future<void> updateProfile({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    await client.post(
      Uri.parse("${url}profile"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: json.encode(data),
    );
  }

  Future<void> updatePassword({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    await client.put(
      Uri.parse("${url}password"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: json.encode(data),
    );
  }

  Future<String> _getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.utsname.machine;
    }

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
    }

    if (Platform.isFuchsia) {
      return "Fuchsia Device";
    }

    return "";
  }

  Future<bool> isTokenExpired() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? expiresAt = prefs.getString(LocalStorageKey.expiresAt.value);

    if (expiresAt == null) {
      return true;
    }

    DateTime date = DateTime.parse(expiresAt);

    if (DateTime.now().isAfter(date)) {
      _deleteUserInfo();
      return true;
    }

    return false;
  }

  Future<void> _saveUserInfo(Map<String, dynamic> body) async {
    String token = body["token"] ?? "";
    String expiresAt = body["expires_at"] ?? "";

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(LocalStorageKey.accessToken.value, token);
    prefs.setString(LocalStorageKey.expiresAt.value, expiresAt);
  }

  Future<void> _deleteUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(LocalStorageKey.accessToken.value);
    prefs.remove(LocalStorageKey.expiresAt.value);
  }
}
