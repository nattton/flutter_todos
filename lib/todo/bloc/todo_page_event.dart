part of 'todo_page_bloc.dart';

@freezed
sealed class TodoPageEvent with _$TodoPageEvent {
  const factory TodoPageEvent.adding() = _Adding;

  const factory TodoPageEvent.editing({required TodoItem item}) = _Editing;

  const factory TodoPageEvent.listing() = _Listing;

  const factory TodoPageEvent.save({required TodoItem item}) = _Save;

  const factory TodoPageEvent.remove({required String id}) = _Remove;

  const factory TodoPageEvent.toggleComplete({required String id}) =
      _ToggleComplete;
}
