import 'package:flutter/foundation.dart';
import 'package:flutter_todos/features/todos/todo.dart';
import 'package:uuid/uuid.dart';

enum TodoPageStatus { listing, editing }

class TodosViewModel extends ChangeNotifier {
  TodoPageStatus _status = TodoPageStatus.listing;
  List<TodoItem> _items = [];
  String _editingId = '';
  String _editingTitle = '';
  bool _editingCompleted = false;

  TodoPageStatus get status => _status;
  List<TodoItem> get items => _items;
  String get editingId => _editingId;
  String get editingTitle => _editingTitle;

  void setEditingTitle(String title) {
    _editingTitle = title;
    notifyListeners();
  }

  void startNewEditing() {
    _status = TodoPageStatus.editing;
    _editingId = '';
    _editingTitle = '';
    _editingCompleted = false;
    notifyListeners();
  }

  void startEditing(TodoItem item) {
    _status = TodoPageStatus.editing;
    _editingId = item.id;
    _editingTitle = item.title;
    _editingCompleted = item.completed;
    notifyListeners();
  }

  void stopEditing() {
    _status = TodoPageStatus.listing;
    clearEditing();
    notifyListeners();
  }

  void clearEditing() {
    _editingId = '';
    _editingTitle = '';
    _editingCompleted = false;
    notifyListeners();
  }

  void saveTodo() {
    if (_editingTitle.isEmpty) {
      return;
    }

    final item = TodoItem(
      id: _editingId,
      title: _editingTitle,
      completed: _editingCompleted,
    );

    if (item.id.isNotEmpty) {
      _items = _items.map((i) => i.id == item.id ? item : i).toList();
    } else {
      final newItem = item.copyWith(id: const Uuid().v4());
      _items = [..._items, newItem];
    }
    _status = TodoPageStatus.listing;
    clearEditing();
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
