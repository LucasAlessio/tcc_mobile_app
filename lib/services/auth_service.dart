import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:tcc/models/user.dart';
import 'package:tcc/services/web_client.dart';

class AuthService {
  String url = WebClient.url;
  http.Client client = WebClient.client;
  http.Client unauthorizedClient = WebClient.unauthorizedClient;

  Future<User> login({required Map<String, dynamic> data}) async {
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

    return User.fromMap(json.decode(response.body));
  }

  Future<User> register({required Map<String, dynamic> data}) async {
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

    return User.fromMap(json.decode(response.body));
  }

  Future<void> logout() async {
    await client.post(
      Uri.parse("${url}logout"),
      headers: {
        "Content-Type": "application/json",
      },
    );
  }

  Future<Map<String, dynamic>> getProfile() async {
    http.Response response = await client.get(
      Uri.parse("${url}profile"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    return json.decode(response.body);
  }

  Future<void> updateProfile({required Map<String, dynamic> data}) async {
    await client.post(
      Uri.parse("${url}profile"),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(data),
    );
  }

  Future<void> updatePassword({required Map<String, dynamic> data}) async {
    await client.put(
      Uri.parse("${url}password"),
      headers: {
        "Content-Type": "application/json",
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
}
