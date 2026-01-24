import 'package:flutter/services.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todos/app/app.dart';
import 'package:flutter_todos/features/todos/todo.dart';
import 'package:flutter_todos/main_development.dart';

void main() {
  setUp(() async {
    const channel = MethodChannel('plugins.flutter.io/path_provider');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          channel,
          (MethodCall methodCall) async {
            return '.';
          },
        );
    await configureDependencies();
  });

  tearDown(() async {
    await di.reset();
  });

  group('App', () {
    testWidgets('renders TodoPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(TodoPage), findsOneWidget);
    });
  });
}
