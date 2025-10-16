import 'package:flutter_todos/app/app.dart';
import 'package:flutter_todos/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
