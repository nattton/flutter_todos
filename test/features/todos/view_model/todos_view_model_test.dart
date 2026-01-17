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
      expect(viewModel.editingId, '');
      expect(viewModel.editingTitle, '');
    });

    test('startEditing updates status and editingItem', () {
      const item = TodoItem(id: '1', title: 'Test');
      viewModel.startEditing(item);
      expect(viewModel.status, TodoPageStatus.editing);
      expect(viewModel.editingId, item.id);
      expect(viewModel.editingTitle, item.title);
    });

    test('stopEditing resets status and editingItem', () {
      const item = TodoItem(id: '1', title: 'Test');
      viewModel.startEditing(item);
      viewModel.stopEditing();
      expect(viewModel.status, TodoPageStatus.listing);
      expect(viewModel.editingId, '');
      expect(viewModel.editingTitle, '');
    });

    test('saveTodo adds new item', () {
      viewModel.startEditing(const TodoItem(id: '', title: 'Test'));
      viewModel.saveTodo();
      expect(viewModel.items.length, 1);
      expect(viewModel.items.first.title, 'Test');
      expect(viewModel.items.first.id, isNotEmpty);
      expect(viewModel.status, TodoPageStatus.listing);
      expect(viewModel.editingId, '');
      expect(viewModel.editingTitle, '');
    });

    test('saveTodo updates existing item', () {
      viewModel.startEditing(const TodoItem(id: '', title: 'Initial'));
      viewModel.saveTodo();
      final addedId = viewModel.items.first.id;

      viewModel.startEditing(const TodoItem(id: '', title: 'Updated'));
      viewModel.saveTodo();

      expect(viewModel.items.length, 2);
      expect(viewModel.items.first.title, 'Initial');
      expect(viewModel.items.first.id, addedId);
      expect(viewModel.items.last.title, 'Updated');
      expect(viewModel.items.last.id, isNotEmpty);
      expect(viewModel.status, TodoPageStatus.listing);
      expect(viewModel.editingId, '');
      expect(viewModel.editingTitle, '');
    });

    test('removeTodo removes item', () {
      viewModel.startEditing(const TodoItem(id: '', title: 'Test'));
      viewModel.saveTodo();
      final id = viewModel.items.first.id;
      viewModel.removeTodo(id);
      expect(viewModel.items, isEmpty);
      expect(viewModel.status, TodoPageStatus.listing);
      expect(viewModel.editingId, '');
      expect(viewModel.editingTitle, '');
    });

    test('toggleTodo toggles completion', () {
      viewModel.startEditing(const TodoItem(id: '', title: 'Test'));
      viewModel.saveTodo();
      final id = viewModel.items.first.id;

      viewModel.toggleTodo(id);
      expect(viewModel.items.first.completed, true);
      expect(viewModel.status, TodoPageStatus.listing);
      expect(viewModel.editingId, '');
      expect(viewModel.editingTitle, '');

      viewModel.toggleTodo(id);
      expect(viewModel.items.first.completed, false);
      expect(viewModel.status, TodoPageStatus.listing);
      expect(viewModel.editingId, '');
      expect(viewModel.editingTitle, '');
    });
  });
}
