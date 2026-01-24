import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:flutter_todos/app/app.dart';
import 'package:flutter_todos/bootstrap.dart';
import 'package:flutter_todos/data/services/api_client.dart';
import 'package:flutter_todos/data/services/local_api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> configureDependencies() async {
  di
    ..registerSingletonAsync<SharedPreferences>(
      () async => SharedPreferences.getInstance(),
    )
    ..registerSingletonWithDependencies<ApiClient>(
      () => LocalApiClient(prefs: di<SharedPreferences>()),
      dependsOn: [SharedPreferences],
    );
  await di.allReady();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await bootstrap(App.new);
}
