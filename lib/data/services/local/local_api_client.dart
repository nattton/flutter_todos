import 'package:flutter_todos/data/services/api_client.dart';
import 'package:flutter_todos/data/services/models/todo_dto.dart';
import 'package:hive_ce/hive.dart';
import 'package:uuid/uuid.dart';

class LocalApiClient implements ApiClient {
  LocalApiClient(Box<TodoDto> box) : _box = box;
  final Box<TodoDto> _box;

  @override
  Future<List<TodoDto>> getTodos() async {
    final todos = _box.values.toList()
      ..sort((a, b) => a.title.compareTo(b.title));
    return todos;
  }

  @override
  Future<TodoDto> addTodo(TodoDto todo) async {
    final newTodo = todo.copyWith(id: const Uuid().v4());
    await _box.put(newTodo.id, newTodo);
    return newTodo;
  }

  @override
  Future<TodoDto> updateTodo(TodoDto todo) async {
    await _box.put(todo.id, todo);
    return todo;
  }

  @override
  Future<void> deleteTodo(String id) async {
    await _box.delete(id);
  }
}
