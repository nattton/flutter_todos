import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todos/data/services/http/http_api_client.dart';
import 'package:flutter_todos/data/services/models/todo_dto.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('HttpApiClient', () {
    late http.Client httpClient;
    late HttpApiClient apiClient;

    setUp(() {
      httpClient = MockHttpClient();
      apiClient = HttpApiClient(client: httpClient);
      registerFallbackValue(Uri());
    });

    group('getTodos', () {
      test('returns list of todos on 200 OK', () async {
        final todos = [
          const TodoDto(id: '1', title: 'Todo 1'),
          const TodoDto(id: '2', title: 'Todo 2'),
        ];
        when(() => httpClient.get(any())).thenAnswer(
          (_) async => http.Response(jsonEncode(todos), 200),
        );

        final result = await apiClient.getTodos();

        expect(result, isNotEmpty);
        expect(result.first.title, equals('Todo 1'));
        verify(
          () => httpClient.get(
            Uri.parse('https://jsonplaceholder.typicode.com/todos'),
          ),
        ).called(1);
      });

      test('throws Exception on non-200', () async {
        when(() => httpClient.get(any())).thenAnswer(
          (_) async => http.Response('Error', 404),
        );

        expect(apiClient.getTodos(), throwsException);
      });
    });

    group('addTodo', () {
      test('returns todo on 201 Created', () async {
        const todo = TodoDto(id: '1', title: 'New Todo');
        when(
          () => httpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => http.Response(jsonEncode(todo), 201));

        final result = await apiClient.addTodo(todo);

        expect(result, equals(todo));
        verify(
          () => httpClient.post(
            Uri.parse('https://jsonplaceholder.typicode.com/todos'),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).called(1);
      });

      test('throws Exception on failure', () async {
        const todo = TodoDto(id: '1', title: 'New Todo');
        when(
          () => httpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => http.Response('Error', 400));

        expect(apiClient.addTodo(todo), throwsException);
      });
    });

    group('updateTodo', () {
      test('returns todo on 200 OK', () async {
        const todo = TodoDto(id: '1', title: 'Updated Todo');
        when(
          () => httpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => http.Response(jsonEncode(todo), 200));

        final result = await apiClient.updateTodo(todo);

        expect(result, equals(todo));
        verify(
          () => httpClient.put(
            Uri.parse('https://jsonplaceholder.typicode.com/todos/1'),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).called(1);
      });

      test('throws Exception on failure', () async {
        const todo = TodoDto(id: '1', title: 'Updated Todo');
        when(
          () => httpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => http.Response('Error', 404));

        expect(apiClient.updateTodo(todo), throwsException);
      });
    });

    group('deleteTodo', () {
      test('completes on 200 OK', () async {
        when(() => httpClient.delete(any())).thenAnswer(
          (_) async => http.Response('', 200),
        );

        await apiClient.deleteTodo('1');

        verify(
          () => httpClient.delete(
            Uri.parse('https://jsonplaceholder.typicode.com/todos/1'),
          ),
        ).called(1);
      });

      test('throws Exception on failure', () async {
        when(() => httpClient.delete(any())).thenAnswer(
          (_) async => http.Response('Error', 404),
        );

        expect(apiClient.deleteTodo('1'), throwsException);
      });
    });
  });
}
