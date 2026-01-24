import 'package:flutter_it/flutter_it.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todos/app/app.dart';
import 'package:flutter_todos/features/todos/todo.dart';
import 'package:flutter_todos/main_development.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await configureDependencies();
  });

  tearDownAll(() async {
    await di.reset();
  });

  group('App', () {
    testWidgets('renders TodoPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(TodoPage), findsOneWidget);
    });
  });
}
