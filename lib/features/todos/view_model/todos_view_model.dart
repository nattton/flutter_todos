import 'package:flutter/foundation.dart';
import 'package:flutter_todos/features/todos/todo.dart';
import 'package:uuid/uuid.dart';

enum TodoPageStatus { listing, editing }

class TodosViewModel extends ChangeNotifier {
  TodoPageStatus _status = TodoPageStatus.listing;
  List<TodoItem> _items = [];
  TodoItem? _editingItem;

  TodoPageStatus get status => _status;
  List<TodoItem> get items => _items;
  TodoItem? get editingItem => _editingItem;

  void startEditing(TodoItem item) {
    _status = TodoPageStatus.editing;
    _editingItem = item;
    notifyListeners();
  }

  void stopEditing() {
    _status = TodoPageStatus.listing;
    _editingItem = null;
    notifyListeners();
  }

  void saveTodo(TodoItem item) {
    if (item.id.isNotEmpty) {
      _items = _items.map((i) => i.id == item.id ? item : i).toList();
    } else {
      final newItem = item.copyWith(id: const Uuid().v4());
      _items = [..._items, newItem];
    }
    _status = TodoPageStatus.listing;
    _editingItem = null;
    notifyListeners();
  }

  void removeTodo(String id) {
    _items = _items.where((item) => item.id != id).toList();
    notifyListeners();
  }

  void toggleTodo(String id) {
    _items = _items.map((item) {
      if (item.id == id) {
        return item.copyWith(completed: !item.completed);
      }
      return item;
    }).toList();
    notifyListeners();
  }
}
