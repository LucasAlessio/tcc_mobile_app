import 'package:flutter/cupertino.dart';
import "package:http/http.dart" as http;
import 'package:http_interceptor/http/intercepted_client.dart';

import 'http_interceptors.dart';

class WebClient {
  static const String url = "http://10.0.2.2:8000/api/";

  static http.Client client = InterceptedClient.build(
    interceptors: [
      LoggingInterceptor(null),
    ],
    requestTimeout: const Duration(minutes: 1),
  );

  static http.Client getClient(BuildContext context) {
    return InterceptedClient.build(
      interceptors: [
        LoggingInterceptor(context),
      ],
      requestTimeout: const Duration(minutes: 1),
    );
  }
}
