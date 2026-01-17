import 'package:flutter_todos/data/services/models/todo_dto.dart';

abstract class ApiClient {
  Future<List<TodoDto>> getTodos();
  Future<TodoDto> addTodo(TodoDto todo);
  Future<TodoDto> updateTodo(TodoDto todo);
  Future<void> deleteTodo(String id);
}
