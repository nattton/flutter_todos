import 'package:flutter/material.dart';
import 'package:flutter_todos/app/app.dart';
import 'package:flutter_todos/bootstrap.dart';
import 'package:flutter_todos/core/di/injector_prod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureProdDependencies();
  await bootstrap(App.new);
}
