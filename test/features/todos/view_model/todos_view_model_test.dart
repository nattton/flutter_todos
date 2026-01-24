import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todos/data/services/api_client.dart';
import 'package:flutter_todos/data/services/models/todo_dto.dart';
import 'package:flutter_todos/features/todos/view_model/todos_view_model.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  group('TodosViewModel', () {
    late TodosViewModel viewModel;
    late MockApiClient mockApiClient;

    setUpAll(() {
      registerFallbackValue(const TodoDto(id: 'fallback', title: 'fallback'));
    });

    setUp(() {
      mockApiClient = MockApiClient();
      when(() => mockApiClient.getTodos()).thenAnswer((_) async => []);
      // Default stubs
      when(() => mockApiClient.addTodo(any())).thenAnswer(
        (invocation) async => invocation.positionalArguments.first as TodoDto,
      );
      when(() => mockApiClient.updateTodo(any())).thenAnswer(
        (invocation) async => invocation.positionalArguments.first as TodoDto,
      );
      when(() => mockApiClient.deleteTodo(any())).thenAnswer((_) async {});

      viewModel = TodosViewModel(apiClient: mockApiClient);
    });

    test('initial state is correct', () {
      expect(viewModel.status, TodoPageStatus.listing);
      expect(viewModel.items, isEmpty);
      expect(viewModel.editingId, '');
      expect(viewModel.editingTitle, '');
    });

    test('startEditing updates status and editingItem', () {
      const item = TodoDto(id: '1', title: 'Test');
      viewModel.startEditing(item);
      expect(viewModel.status, TodoPageStatus.editing);
      expect(viewModel.editingId, item.id);
      expect(viewModel.editingTitle, item.title);
    });

    test('stopEditing resets status and editingItem', () {
      const item = TodoDto(id: '1', title: 'Test');
      viewModel
        ..startEditing(item)
        ..stopEditing();
      expect(viewModel.status, TodoPageStatus.listing);
      expect(viewModel.editingId, '');
      expect(viewModel.editingTitle, '');
    });

    test('saveTodo adds new item', () async {
      viewModel.startEditing(const TodoDto(id: '', title: 'Test'));

      // return list with 1 item when getTodos is called during init()
      when(
        () => mockApiClient.getTodos(),
      ).thenAnswer((_) async => [const TodoDto(id: '123', title: 'Test')]);

      await viewModel.saveTodo();

      verify(() => mockApiClient.addTodo(any())).called(1);
      verify(
        () => mockApiClient.getTodos(),
      ).called(1); // called inside saveTodo->init

      expect(viewModel.items.length, 1);
      expect(viewModel.items.first.title, 'Test');
      expect(viewModel.items.first.id, '123'); // From our mocked getTodos
      expect(viewModel.status, TodoPageStatus.listing);
      expect(viewModel.editingId, '');
      expect(viewModel.editingTitle, '');
    });

    test('saveTodo updates existing item', () async {
      // First add an item (simulating it being there)
      const initialItem = TodoDto(id: '1', title: 'Initial');

      var callCount = 0;
      when(() => mockApiClient.getTodos()).thenAnswer((_) async {
        callCount++;
        if (callCount == 1) return [initialItem]; // Initial state
        return [const TodoDto(id: '1', title: 'Updated')]; // After update
      });

      // Initialize with data
      await viewModel.init();

      viewModel
        ..startEditing(initialItem)
        ..setEditingTitle('Updated');

      await viewModel.saveTodo();

      verify(() => mockApiClient.updateTodo(any())).called(1);

      expect(viewModel.items.length, 1);
      expect(viewModel.items.first.title, 'Updated');
      expect(viewModel.items.first.id, '1');
      expect(viewModel.status, TodoPageStatus.listing);
    });

    test('removeTodo removes item', () async {
      // Optimistic upate test
      // Initialize with one item
      when(
        () => mockApiClient.getTodos(),
      ).thenAnswer((_) async => [const TodoDto(id: '1', title: 'Test')]);
      await viewModel.init();
      expect(viewModel.items.length, 1);

      await viewModel.removeTodo('1');

      verify(() => mockApiClient.deleteTodo('1')).called(1);
      expect(viewModel.items, isEmpty);
    });

    test('toggleTodo toggles completion', () async {
      // Initialize with one item
      const item = TodoDto(id: '1', title: 'Test');
      when(() => mockApiClient.getTodos()).thenAnswer((_) async => [item]);
      await viewModel.init();

      await viewModel.toggleTodo('1');

      verify(
        () => mockApiClient.updateTodo(
          any(
            that: isA<TodoDto>().having((t) => t.completed, 'completed', true),
          ),
        ),
      ).called(1);
      expect(viewModel.items.first.completed, true);

      await viewModel.toggleTodo('1');

      verify(
        () => mockApiClient.updateTodo(
          any(
            that: isA<TodoDto>().having((t) => t.completed, 'completed', false),
          ),
        ),
      ).called(1);
      expect(viewModel.items.first.completed, false);
    });
    test('setEditingTitle updates editingTitle', () {
      viewModel.setEditingTitle('New Title');
      expect(viewModel.editingTitle, 'New Title');
    });

    test('clearEditing resets editing fields', () {
      const item = TodoDto(id: '1', title: 'Test');
      viewModel.startEditing(item);
      expect(viewModel.editingId, '1');

      viewModel.clearEditing();

      expect(viewModel.editingId, '');
      expect(viewModel.editingTitle, '');
      expect(
        viewModel.status,
        TodoPageStatus.editing,
      ); // clearEditing doesn't change status
    });

    test('saveTodo returns early if editingTitle is empty', () async {
      viewModel.startNewEditing();
      // Title is empty by default

      await viewModel.saveTodo();

      verifyNever(() => mockApiClient.addTodo(any()));
      verifyNever(() => mockApiClient.updateTodo(any()));
    });

    test('saveTodo handles exception and resets status', () async {
      viewModel
        ..startNewEditing()
        ..setEditingTitle('Fail');

      when(() => mockApiClient.addTodo(any())).thenThrow(Exception('Failed'));

      await viewModel.saveTodo();

      verify(() => mockApiClient.addTodo(any())).called(1);
      expect(viewModel.status, TodoPageStatus.listing);
      expect(viewModel.editingTitle, '');
    });

    test('removeTodo reverts optimistic update on failure', () async {
      const item = TodoDto(id: '1', title: 'Test');
      when(() => mockApiClient.getTodos()).thenAnswer((_) async => [item]);
      when(
        () => mockApiClient.deleteTodo(any()),
      ).thenThrow(Exception('Failed'));

      await viewModel.init();
      expect(viewModel.items.length, 1);

      await viewModel.removeTodo('1');

      verify(() => mockApiClient.deleteTodo('1')).called(1);
      // Items should be present again after revert
      expect(viewModel.items.length, 1);
      expect(viewModel.items.first, item);
    });

    test('toggleTodo reverts optimistic update on failure', () async {
      const item = TodoDto(id: '1', title: 'Test'); // completed: false
      when(() => mockApiClient.getTodos()).thenAnswer((_) async => [item]);
      when(
        () => mockApiClient.updateTodo(any()),
      ).thenThrow(Exception('Failed'));

      await viewModel.init();

      await viewModel.toggleTodo('1');

      verify(() => mockApiClient.updateTodo(any())).called(1);
      // Should revert to false
      expect(viewModel.items.first.completed, false);
    });
  });
}
