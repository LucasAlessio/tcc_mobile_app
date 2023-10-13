import 'dart:io';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:tcc/exceptions/unauthorized_exception.dart';
import 'package:tcc/services/auth_service.dart';

class AuthorizationInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    AuthService service = AuthService();
    if (await service.isTokenExpired()) {
      throw UnauthorizedException(
        "Sua sessão expirou. Faça o login novamente para continuar.",
      );
    }

    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException(
        "Sua sessão expirou. Faça o login novamente para continuar.",
      );
    }

    return data;
  }
}
