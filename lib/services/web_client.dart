import "package:http/http.dart" as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:tcc/services/interceptors/authorization_interceptor.dart';
import 'package:tcc/services/interceptors/map_response_interceptor.dart';

import 'interceptors/logging_interceptor.dart';

class WebClient {
  static const String url = "https://serene.alessio.net.br/api/";
  // static const String url = "http://10.0.2.2:8000/api/";

  static http.Client client = InterceptedClient.build(
    interceptors: [
      AuthorizationInterceptor(),
      MapResponseInterceptor(),
      LoggingInterceptor(),
    ],
    requestTimeout: const Duration(minutes: 1),
  );

  static http.Client unauthorizedClient = InterceptedClient.build(
    interceptors: [
      MapResponseInterceptor(),
      LoggingInterceptor(),
    ],
    requestTimeout: const Duration(minutes: 1),
  );
}
