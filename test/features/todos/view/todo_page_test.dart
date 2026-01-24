import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todos/data/services/api_client.dart';
import 'package:flutter_todos/data/services/models/todo_dto.dart';
import 'package:flutter_todos/features/todos/todo.dart';
import 'package:flutter_todos/l10n/l10n.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  group('TodoPage', () {
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

    Widget buildSubject() {
      return const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: TodoPage(),
      );
    }

    testWidgets('renders list of todos', (tester) async {
      final todos = [
        const TodoDto(id: '1', title: 'Todo 1'),
        const TodoDto(id: '2', title: 'Todo 2', completed: true),
      ];
      when(() => apiClient.getTodos()).thenAnswer((_) async => todos);

      await tester.pumpWidget(buildSubject());
      await tester.pump(); // Allow init to complete

      expect(find.text('Todo 1'), findsOneWidget);
      expect(find.text('Todo 2'), findsOneWidget);

      // Verify Todo 2 has line-through (completed)
      final todo2Text = tester.widget<Text>(find.text('Todo 2'));
      expect(todo2Text.style?.decoration, TextDecoration.lineThrough);
    });

    testWidgets('toggling todo calls updateTodo', (tester) async {
      final todos = [const TodoDto(id: '1', title: 'Todo 1')];
      when(() => apiClient.getTodos()).thenAnswer((_) async => todos);
      when(() => apiClient.updateTodo(any())).thenAnswer(
        (invocation) async => invocation.positionalArguments.first as TodoDto,
      );

      await tester.pumpWidget(buildSubject());
      await tester.pump();

      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      verify(
        () => apiClient.updateTodo(
          any(
            that: isA<TodoDto>().having((t) => t.completed, 'completed', true),
          ),
        ),
      ).called(1);
    });

    testWidgets('deleting todo calls deleteTodo', (tester) async {
      final todos = [const TodoDto(id: '1', title: 'Todo 1')];
      when(() => apiClient.getTodos()).thenAnswer((_) async => todos);
      when(() => apiClient.deleteTodo(any())).thenAnswer((_) async {});

      await tester.pumpWidget(buildSubject());
      await tester.pump();

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pump();

      verify(() => apiClient.deleteTodo('1')).called(1);
      expect(find.text('Todo 1'), findsNothing);
    });

    testWidgets('tapping FAB shows TodoAddingView', (tester) async {
      when(() => apiClient.getTodos()).thenAnswer((_) async => []);

      await tester.pumpWidget(buildSubject());
      await tester.pump();

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      expect(find.byType(TodoAddingView), findsOneWidget);
    });

    testWidgets('tapping todo item shows TodoAddingView (edit mode)', (
      tester,
    ) async {
      final todos = [const TodoDto(id: '1', title: 'Todo 1')];
      when(() => apiClient.getTodos()).thenAnswer((_) async => todos);

      await tester.pumpWidget(buildSubject());
      await tester.pump();

      await tester.tap(find.text('Todo 1'));
      await tester.pump();

      expect(find.byType(TodoAddingView), findsOneWidget);
      // You might check if the input is pre-filled if TodoAddingView exposes it
      // or via find.text
    });
  });
}
