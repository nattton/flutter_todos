// Ignore for testing purposes
// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todos/app/app.dart';
import 'package:flutter_todos/features/todos/todo.dart';

void main() {
  group('App', () {
    testWidgets('renders TodoPage', (tester) async {
      await tester.pumpWidget(App());
      expect(find.byType(TodoPage), findsOneWidget);
    });
  });
}
