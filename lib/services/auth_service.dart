import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc/enums/local_storage_key.dart';
import 'package:tcc/exceptions/validation_exception.dart';
import 'package:tcc/services/web_client.dart';

class AuthService {
  String url = WebClient.url;
  http.Client client = WebClient.client;

  Future<void> register({required Map<String, dynamic> data}) async {
    Map<String, dynamic> body = {
      ...data,
      'device_name': await _getDeviceName(),
    };

    http.Response response = await client.post(
      Uri.parse("${url}register"),
      headers: {
        // "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: json.encode(body),
    );

    if (response.statusCode >= 300) {
      if (response.statusCode == HttpStatus.unprocessableEntity) {
        throw ValidationException.fromErrorResponse(response.body);
      }

      throw HttpException(response.body);
    }

    await _saveUserInfo(response.body);
  }

  Future<void> logout({required String token}) async {
    http.Response response = await client.post(
      Uri.parse("${url}logout"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode >= 300) {
      if (response.statusCode == HttpStatus.unprocessableEntity) {
        throw ValidationException.fromErrorResponse(response.body);
      }

      throw HttpException(response.body);
    }

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

    if (response.statusCode >= 300) {
      throw HttpException(response.body);
    }

    return jsonDecode(response.body);
  }

  Future<void> saveProfile({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    http.Response response = await client.post(
      Uri.parse("${url}profile"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: json.encode(data),
    );

    if (response.statusCode >= 300) {
      if (response.statusCode == HttpStatus.unprocessableEntity) {
        throw ValidationException.fromErrorResponse(response.body);
      }

      throw HttpException(response.body);
    }
  }

  Future<void> updatePassword({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    http.Response response = await client.put(
      Uri.parse("${url}password"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: json.encode(data),
    );

    if (response.statusCode >= 300) {
      if (response.statusCode == HttpStatus.unprocessableEntity) {
        throw ValidationException.fromErrorResponse(response.body);
      }

      throw HttpException(response.body);
    }
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

  Future<void> _saveUserInfo(String body) async {
    Map<String, dynamic> map = json.decode(body);

    String token = map["token"];
    String expiresAt = map["expires_at"];

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
