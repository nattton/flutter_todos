import 'package:flutter_it/flutter_it.dart';
import 'package:flutter_todos/data/services/api_client.dart';
import 'package:flutter_todos/data/services/http/http_api_client.dart';
import 'package:http/http.dart' as http;

Future<void> configureProdDependencies() async {
  di.registerLazySingleton<ApiClient>(
    () => HttpApiClient(client: http.Client()),
  );
  await di.allReady();
}
