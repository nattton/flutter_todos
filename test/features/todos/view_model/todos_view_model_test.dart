import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todos/features/todos/todo.dart';
import 'package:flutter_todos/features/todos/view_model/todos_view_model.dart';

void main() {
  group('TodosViewModel', () {
    late TodosViewModel viewModel;

    setUp(() {
      viewModel = TodosViewModel();
    });

    test('initial state is correct', () {
      expect(viewModel.status, TodoPageStatus.listing);
      expect(viewModel.items, isEmpty);
      expect(viewModel.editingItem, isNull);
    });

    test('startEditing updates status and editingItem', () {
      const item = TodoItem(id: '1', title: 'Test');
      viewModel.startEditing(item);
      expect(viewModel.status, TodoPageStatus.editing);
      expect(viewModel.editingItem, item);
    });

    test('stopEditing resets status and editingItem', () {
      const item = TodoItem(id: '1', title: 'Test');
      viewModel.startEditing(item);
      viewModel.stopEditing();
      expect(viewModel.status, TodoPageStatus.listing);
      expect(viewModel.editingItem, isNull);
    });

    test('saveTodo adds new item', () {
      const item = TodoItem(id: '', title: 'Test');
      viewModel.saveTodo(item);
      expect(viewModel.items.length, 1);
      expect(viewModel.items.first.title, 'Test');
      expect(viewModel.items.first.id, isNotEmpty);
      expect(viewModel.status, TodoPageStatus.listing);
    });

    test('saveTodo updates existing item', () {
      const item1 = TodoItem(id: '1', title: 'Test 1');
      const item2 = TodoItem(id: '2', title: 'Test 2');
      // Add items manually for testing update (or use saveTodo if ids are generated)
      // Since we need to update existing, let's add one first
      viewModel.saveTodo(const TodoItem(id: '', title: 'Initial'));
      final addedId = viewModel.items.first.id;

      final updatedItem = viewModel.items.first.copyWith(title: 'Updated');
      viewModel.saveTodo(updatedItem);

      expect(viewModel.items.length, 1);
      expect(viewModel.items.first.title, 'Updated');
      expect(viewModel.items.first.id, addedId);
    });

    test('removeTodo removes item', () {
      viewModel.saveTodo(const TodoItem(id: '', title: 'Test'));
      final id = viewModel.items.first.id;
      viewModel.removeTodo(id);
      expect(viewModel.items, isEmpty);
    });

    test('toggleTodo toggles completion', () {
      viewModel.saveTodo(const TodoItem(id: '', title: 'Test'));
      final id = viewModel.items.first.id;

      viewModel.toggleTodo(id);
      expect(viewModel.items.first.completed, true);

      viewModel.toggleTodo(id);
      expect(viewModel.items.first.completed, false);
    });
  });
}
