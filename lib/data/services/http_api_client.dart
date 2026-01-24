import 'dart:convert';

import 'package:flutter_todos/data/services/api_client.dart';
import 'package:flutter_todos/data/services/models/todo_dto.dart';
import 'package:http/http.dart' as http;

class HttpApiClient implements ApiClient {
  HttpApiClient({
    required http.Client client,
    String baseUrl = 'https://jsonplaceholder.typicode.com',
  }) : _client = client,
       _baseUrl = baseUrl;

  final http.Client _client;
  final String _baseUrl;

  @override
  Future<List<TodoDto>> getTodos() async {
    final response = await _client.get(Uri.parse('$_baseUrl/todos'));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as List<dynamic>;
      // jsonplaceholder returns 200 items, let's take first 10 for demo
      return body
          .take(10)
          .map((e) => TodoDto.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }

  @override
  Future<TodoDto> addTodo(TodoDto todo) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/todos'),
      headers: {'Content-type': 'application/json; charset=UTF-8'},
      body: jsonEncode(todo.toJson()),
    );

    if (response.statusCode == 201) {
      // jsonplaceholder always returns id 201 for created items
      // Let's just return the input todo for now with the new ID if we were using a real API
      // For demo, we just trust it succeeded.
      return TodoDto.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to add todo');
    }
  }

  @override
  Future<TodoDto> updateTodo(TodoDto todo) async {
    // jsonplaceholder uses /todos/:id
    final response = await _client.put(
      Uri.parse('$_baseUrl/todos/${todo.id}'),
      headers: {'Content-type': 'application/json; charset=UTF-8'},
      body: jsonEncode(todo.toJson()),
    );
    if (response.statusCode == 200) {
      return TodoDto.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to update todo');
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    final response = await _client.delete(Uri.parse('$_baseUrl/todos/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }
}
