import 'dart:io';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:tcc/exceptions/unauthorized_exception.dart';
import 'package:tcc/logic/preferences/auth_preferences.dart';
import 'package:tcc/logic/tasks/auth_task_scheduler.dart';

class AuthorizationInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    AuthPreferences authPreferences = AuthPreferences();
    await authPreferences.reload();

    if (await authPreferences.isAuthExpired()) {
      authPreferences.deleteAuthData();

      AuthTaskScheduler authTaskScheduler = AuthTaskScheduler();
      authTaskScheduler.cancelRefreshToken();

      throw UnauthorizedException(
        "Sua sessão expirou. Faça o login novamente para continuar.",
      );
    }

    String token = await authPreferences.getToken();
    data.headers["Authorization"] = "Bearer $token";

    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode == HttpStatus.unauthorized) {
      AuthPreferences authPreferences = AuthPreferences();
      authPreferences.deleteAuthData();

      AuthTaskScheduler authTaskScheduler = AuthTaskScheduler();
      authTaskScheduler.cancelRefreshToken();

      throw UnauthorizedException(
        "Sua sessão expirou. Faça o login novamente para continuar.",
      );
    }

    return data;
  }
}
