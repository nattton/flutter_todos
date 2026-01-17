import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:flutter_todos/data/services/api_client.dart';
import 'package:flutter_todos/data/services/models/todo_dto.dart';
import 'package:flutter_todos/features/todos/_manager/todo_manager.dart';
import 'package:flutter_todos/features/todos/_models/todo_proxy.dart';

class FeedDataSource {
  FeedDataSource({this.filter});

  /// select which todos to show in this feed
  final bool Function(TodoDto todoDto)? filter;

  final _todos = <TodoProxy>[];
  final ValueNotifier<int> _todosCount = ValueNotifier(0);
  ValueListenable<int> get todosCount => _todosCount;

  TodoProxy getTodoAtIndex(int index) {
    assert(index >= 0 && index < _todos.length, 'Index out of range');
    return _todos[index];
  }

  late final Command<void, void> updateDataCommand =
      Command.createAsyncNoParamNoResult(
        () async {
          final todoDtos = await di<ApiClient>().getTodos();

          /// decrement the reference count of all proxies
          /// and release the ones that are not anywhere else
          di<TodoManager>().releaseProxies(_todos);
          _todos.clear();

          for (final todoDto in todoDtos) {
            if (filter != null && !filter!(todoDto)) {
              continue;
            }
            _todos.add(di<TodoManager>().createProxy(todoDto));
          }
          _todosCount.value = _todos.length;
        },
      );
}
