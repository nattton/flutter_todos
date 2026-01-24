import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todos/data/services/local_api_client.dart';
import 'package:flutter_todos/data/services/models/todo_dto.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';

class MockBox extends Mock implements Box<TodoDto> {}

void main() {
  group('LocalApiClient', () {
    late Box<TodoDto> box;
    late LocalApiClient apiClient;

    setUpAll(() {
      registerFallbackValue(const TodoDto(id: 'fallback', title: 'fallback'));
    });

    setUp(() {
      box = MockBox();
      apiClient = LocalApiClient(box);
    });

    test('getTodos returns list of todos', () async {
      final todos = [
        const TodoDto(id: '1', title: 'Todo 1'),
        const TodoDto(id: '2', title: 'Todo 2'),
      ];
      when(() => box.values).thenReturn(todos);

      final result = await apiClient.getTodos();

      expect(result, equals(todos));
      verify(() => box.values).called(1);
    });

    test('addTodo adds todo with generated id', () async {
      const todo = TodoDto(id: '', title: 'New Todo');
      when(
        () => box.put(any<String>(), any<TodoDto>()),
      ).thenAnswer((_) async {});

      final result = await apiClient.addTodo(todo);

      expect(result.id, isNotEmpty);
      expect(result.title, equals(todo.title));
      verify(() => box.put(result.id, result)).called(1);
    });

    test('updateTodo updates todo in box', () async {
      const todo = TodoDto(id: '1', title: 'Updated Todo');
      when(
        () => box.put(any<String>(), any<TodoDto>()),
      ).thenAnswer((_) async {});

      final result = await apiClient.updateTodo(todo);

      expect(result, equals(todo));
      verify(() => box.put(todo.id, todo)).called(1);
    });

    test('deleteTodo deletes todo from box', () async {
      const id = '1';
      when(() => box.delete(id)).thenAnswer((_) async {});

      await apiClient.deleteTodo(id);

      verify(() => box.delete(id)).called(1);
    });
  });
}
