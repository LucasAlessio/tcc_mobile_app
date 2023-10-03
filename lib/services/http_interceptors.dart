import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor implements InterceptorContract {
  final BuildContext? context;
  final Logger logger = Logger();

  LoggingInterceptor(this.context) : super();

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    logger.d("Request to ${data.url}\n"
        "Method: ${data.method}\n"
        "Headers: ${data.headers}\n"
        "Body: ${data.body}");

    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    String log =
        "Response from ${data.request?.url} with status ${data.statusCode}\n"
        "Method: ${data.request?.method}\n"
        "Headers: ${data.headers}\n"
        "Body: ${data.body}";

    if (data.statusCode ~/ 100 == 2) {
      logger.i(log);
    } else {
      logger.e(log);
    }

    // if (data.statusCode == HttpStatus.unauthorized) {
    //   Navigator.pushReplacementNamed(
    //       AppConfig.navigatorState.currentContext!, '/login');
    // }

    return data;
  }
}
