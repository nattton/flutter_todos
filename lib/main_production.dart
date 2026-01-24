import 'package:flutter_it/flutter_it.dart';
import 'package:flutter_todos/app/app.dart';
import 'package:flutter_todos/bootstrap.dart';
import 'package:flutter_todos/data/services/api_client.dart';
import 'package:flutter_todos/data/services/http_api_client.dart';
import 'package:http/http.dart' as http;

Future<void> configureDependencies() async {
  di.registerLazySingleton<ApiClient>(
    () => HttpApiClient(client: http.Client()),
  );
  await di.allReady();
}

Future<void> main() async {
  await configureDependencies();
  await bootstrap(App.new);
}
