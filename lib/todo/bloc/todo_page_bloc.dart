import 'package:bloc/bloc.dart';
import 'package:flutter_todos/todo/todo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'todo_page_bloc.freezed.dart';
part 'todo_page_event.dart';
part 'todo_page_state.dart';

class TodoPageBloc extends Bloc<TodoPageEvent, TodoPageState> {
  TodoPageBloc() : super(const TodoPageState()) {
    on<_Editing>(_onEditing);
    on<_Listing>(_onListing);
    on<_Save>(_onSave);
    on<_Remove>(_onRemove);
    on<_ToggleComplete>(_onToggleComplete);
  }

  Future<void> _onEditing(_Editing event, Emitter<TodoPageState> emit) async {
    emit(
      state.copyWith(
        status: TodoPageStatus.editing,
        editingItem: event.item,
      ),
    );
  }

  Future<void> _onListing(_Listing event, Emitter<TodoPageState> emit) async {
    emit(state.copyWith(status: TodoPageStatus.listing));
  }

  Future<void> _onSave(_Save event, Emitter<TodoPageState> emit) async {
    if (event.item.id.isNotEmpty) {
      final updatedItems = state.items.map((item) {
        if (item.id == event.item.id) {
          return event.item;
        }
        return item;
      }).toList();

      emit(
        state.copyWith(
          items: updatedItems,
          status: TodoPageStatus.listing,
          editingItem: null,
        ),
      );
      return;
    }

    final newItem = event.item.copyWith(id: const Uuid().v4());
    emit(
      state.copyWith(
        items: [...state.items, newItem],
        status: TodoPageStatus.listing,
      ),
    );
  }

  Future<void> _onRemove(_Remove event, Emitter<TodoPageState> emit) async {
    emit(
      state.copyWith(
        items: state.items.where((item) => item.id != event.id).toList(),
      ),
    );
  }

  Future<void> _onToggleComplete(
    _ToggleComplete event,
    Emitter<TodoPageState> emit,
  ) async {
    emit(
      state.copyWith(
        items: state.items
            .map(
              (item) => item.id == event.id
                  ? item.copyWith(completed: !item.completed)
                  : item,
            )
            .toList(),
      ),
    );
  }
}
