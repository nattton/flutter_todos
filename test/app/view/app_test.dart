import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todos/app/app.dart';
import 'package:flutter_todos/data/services/api_client.dart';
import 'package:flutter_todos/data/services/models/todo_dto.dart';
import 'package:flutter_todos/features/todos/view/todo_page.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  group('App', () {
    late ApiClient apiClient;

    setUpAll(() {
      registerFallbackValue(const TodoDto(id: 'fallback', title: 'fallback'));
    });

    setUp(() async {
      apiClient = MockApiClient();
      di.registerSingleton<ApiClient>(apiClient);
    });

    tearDown(() async {
      await di.reset();
    });
    testWidgets('renders AppView', (tester) async {
      final todos = [
        const TodoDto(id: '1', title: 'Todo 1'),
        const TodoDto(id: '2', title: 'Todo 2', completed: true),
      ];
      when(() => apiClient.getTodos()).thenAnswer((_) async => todos);

      await tester.pumpWidget(const App(key: Key('app_test')));
      await tester.pump();

      expect(find.byKey(const Key('app_test')), findsOneWidget);
      expect(find.byType(TodoPage), findsOneWidget);
    });
  });
}
