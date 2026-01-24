import 'package:flutter/material.dart';
import 'package:flutter_todos/app/app.dart';
import 'package:flutter_todos/bootstrap.dart';
import 'package:flutter_todos/core/di/injector_dev.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDevDependencies();
  await bootstrap(App.new);
}
