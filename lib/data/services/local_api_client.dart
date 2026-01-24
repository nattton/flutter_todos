import 'dart:convert';

import 'package:flutter_todos/data/services/api_client.dart';
import 'package:flutter_todos/data/services/models/todo_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class LocalApiClient implements ApiClient {
  LocalApiClient({required SharedPreferences prefs}) : _prefs = prefs;
  final SharedPreferences _prefs;

  static const todosKey = 'todos';

  @override
  Future<List<TodoDto>> getTodos() async {
    final todosString = _prefs.getString(todosKey);
    final todos = todosString != null
        ? (jsonDecode(todosString) as List<dynamic>)
              .map((e) => TodoDto.fromJson(e as Map<String, dynamic>))
              .toList()
        : <TodoDto>[];
    return todos;
  }

  @override
  Future<TodoDto> addTodo(TodoDto todo) async {
    final todos = await getTodos();
    final updatedTodos = [...todos, todo.copyWith(id: const Uuid().v4())];
    await _prefs.setString(todosKey, jsonEncode(updatedTodos));
    return todo;
  }

  @override
  Future<TodoDto> updateTodo(TodoDto todo) async {
    final todos = await getTodos();
    final updatedTodos = todos.map((t) => t.id == todo.id ? todo : t).toList();
    await _prefs.setString(todosKey, jsonEncode(updatedTodos));
    return todo;
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todos = await getTodos();
    final updatedTodos = todos.where((todo) => todo.id != id).toList();
    await _prefs.setString(todosKey, jsonEncode(updatedTodos));
  }
}
