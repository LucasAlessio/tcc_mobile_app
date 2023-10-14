import 'dart:io';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:tcc/exceptions/unauthorized_exception.dart';
import 'package:tcc/logic/preferences/auth_preferences.dart';

class AuthorizationInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    AuthPreferences authPreferences = AuthPreferences();

    if (await authPreferences.isAuthExpired()) {
      throw UnauthorizedException(
        "Sua sessão expirou. Faça o login novamente para continuar. 1",
      );
    }

    String token = await authPreferences.getToken();
    data.headers["Authorization"] = "Bearer $token";

    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException(
        "Sua sessão expirou. Faça o login novamente para continuar. 2",
      );
    }

    return data;
  }
}
