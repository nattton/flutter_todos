import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:flutter_todos/app/app.dart';
import 'package:flutter_todos/bootstrap.dart';
import 'package:flutter_todos/data/services/api_client.dart';
import 'package:flutter_todos/data/services/local_api_client.dart';
import 'package:flutter_todos/data/services/models/todo_dto.dart';
import 'package:flutter_todos/hive_registrar.g.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

const todosKey = 'todos';

Future<void> configureDependencies() async {
  await Hive.initFlutter();
  Hive.registerAdapters();
  di.registerSingletonAsync<ApiClient>(
    () async => LocalApiClient(await Hive.openBox<TodoDto>(todosKey)),
  );
  await di.allReady();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await bootstrap(App.new);
}
