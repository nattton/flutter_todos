import 'package:flutter/foundation.dart';
import 'package:flutter_todos/data/services/api_client.dart';
import 'package:flutter_todos/data/services/models/todo_dto.dart';

enum TodoPageStatus { listing, editing }

class TodosViewModel extends ChangeNotifier {
  TodosViewModel({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<void> init() async {
    _items = await _apiClient.getTodos();
    notifyListeners();
  }

  TodoPageStatus _status = TodoPageStatus.listing;
  List<TodoDto> _items = [];
  String _editingId = '';
  String _editingTitle = '';
  bool _editingCompleted = false;

  TodoPageStatus get status => _status;
  List<TodoDto> get items => _items;
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

  void startEditing(TodoDto item) {
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

  Future<void> saveTodo() async {
    if (_editingTitle.isEmpty) {
      return;
    }

    final item = TodoDto(
      id: _editingId,
      title: _editingTitle,
      completed: _editingCompleted,
    );

    try {
      if (_editingId.isNotEmpty) {
        await _apiClient.updateTodo(item);
        await init();
      } else {
        await _apiClient.addTodo(item);
        await init();
      }
    } on Exception catch (_) {}
    _status = TodoPageStatus.listing;
    clearEditing();
    notifyListeners();
  }

  Future<void> removeTodo(String id) async {
    // Optimistic update
    final oldItems = _items;
    _items = _items.where((item) => item.id != id).toList();
    notifyListeners();
    try {
      await _apiClient.deleteTodo(id);
    } on Exception catch (_) {
      _items = oldItems;
      notifyListeners();
    }
  }

  Future<void> toggleTodo(String id) async {
    // Optimistic update
    final oldItems = _items;
    final item = _items.firstWhere((item) => item.id == id);
    final updatedItem = item.copyWith(completed: !item.completed);
    _items = _items.map((i) => i.id == id ? updatedItem : i).toList();
    notifyListeners();
    try {
      await _apiClient.updateTodo(updatedItem);
    } on Exception catch (_) {
      _items = oldItems;
      notifyListeners();
    }
  }
}
