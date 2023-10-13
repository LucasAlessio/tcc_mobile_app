import "package:http/http.dart" as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:tcc/services/authorization_interceptor.dart';
import 'package:tcc/services/map_response_interceptor.dart';

import 'logging_interceptor.dart';

class WebClient {
  static const String url = "http://10.0.2.2:8000/api/";

  static http.Client client = InterceptedClient.build(
    interceptors: [
      LoggingInterceptor(),
      AuthorizationInterceptor(),
      MapResponseInterceptor(),
    ],
    requestTimeout: const Duration(minutes: 1),
  );

  static http.Client unauthorizedClient = InterceptedClient.build(
    interceptors: [
      LoggingInterceptor(),
      MapResponseInterceptor(),
    ],
    requestTimeout: const Duration(minutes: 1),
  );
}
