import 'dart:convert';
import 'dart:io';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:tcc/exceptions/validation_exception.dart';

class MapResponseInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode < 300) {
      return data;
    }

    if (data.statusCode == HttpStatus.unprocessableEntity) {
      throw ValidationException.fromErrorResponse(data.body ?? "");
    }

    Map<String, dynamic> response = {};

    try {
      response = json.decode(data.body ?? "");
    } catch (_) {
      response = {
        "message": data.body,
      };
    }

    throw HttpException(response["message"] ?? data.body);
  }
}
