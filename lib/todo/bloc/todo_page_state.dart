part of 'todo_page_bloc.dart';

enum TodoPageStatus { listing, adding, editing }

@freezed
abstract class TodoPageState with _$TodoPageState {
  const factory TodoPageState({
    @Default(TodoPageStatus.listing) TodoPageStatus status,
    @Default([]) List<TodoItem> items,
    TodoItem? editingItem,
  }) = _TodoState;
}
