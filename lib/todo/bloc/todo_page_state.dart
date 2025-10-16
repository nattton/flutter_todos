part of 'todo_page_bloc.dart';

enum TodoPageStatus { listing, adding }

@freezed
abstract class TodoPageState with _$TodoPageState {
  const factory TodoPageState({
    @Default(TodoPageStatus.listing) TodoPageStatus status,
    @Default([]) List<TodoItem> items,
  }) = _TodoState;
}
