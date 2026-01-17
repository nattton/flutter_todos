import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:flutter_todos/data/services/api_client.dart';
import 'package:flutter_todos/data/services/models/todo_dto.dart';
import 'package:flutter_todos/features/todos/_manager/todo_manager.dart';

class TodoProxy extends ChangeNotifier {
  TodoProxy(this._target);
  late TodoDto _target;
  int referenceCount = 0;

  //setter for the target
  set target(TodoDto value) {
    _updateTarget(value);
  }

  void _updateTarget(TodoDto todoDto) {
    _completed = null;
    _target = todoDto;
    notifyListeners();
  }

  String get id => _target.id;
  String get title => _target.title;
  bool get completed => _completed ?? _target.completed;
  // optimistic UI update
  bool? _completed;

  /// create a combined ValueListenable based on the updateDataCommands of
  /// the data sources and local updateFromApiCommand
  late ValueListenable<bool> commandRestrictions = di<TodoManager>()
      .updateFromApiIsExecuting
      .combineLatest(updateFromApiCommand.isRunning, (a, b) => a || b);

  late final Command<void, void> updateFromApiCommand =
      Command.createAsyncNoParamNoResult(
        () async {
          if (_target.id.isEmpty) {
            final postDto = await di<ApiClient>().addTodo(_target);
            _updateTarget(postDto);
          } else {
            final postDto = await di<ApiClient>().updateTodo(_target);
            _updateTarget(postDto);
          }
        },
        // block the command if any updateDataCommand is executing
        restriction: di<TodoManager>().updateFromApiIsExecuting,
      );

  late final Command<void, void> completeCommand =
      Command.createAsyncNoParamNoResult(
          () async {
            /// optimistic UI update
            _completed = true;
            notifyListeners();
            await di<ApiClient>().updateTodo(_target.copyWith(completed: true));
          },
          // block the command if we update from the api
          restriction: commandRestrictions,
          // we want that the error is handled locally and globally in TheAppImplementation
          errorFilter: const LocalAndGlobalErrorFilter(),
        )
        ..errors.listen(
          (e, _) {
            // reverse the optimistic UI update
            _completed = !_completed!;
            notifyListeners();
          },
        );

  late final Command<void, void> uncompleteCommand =
      Command.createAsyncNoParamNoResult(
          () async {
            /// optimistic UI update
            _completed = false;
            notifyListeners();
            await di<ApiClient>().updateTodo(
              _target.copyWith(completed: false),
            );
          },
          // block the command if we update from the api
          restriction: commandRestrictions,
          errorFilter: const LocalAndGlobalErrorFilter(),
        )
        ..errors.listen(
          (e, _) {
            // reverse the optimistic UI update
            _completed = !_completed!;
            notifyListeners();
          },
        );

  @override
  void dispose() {
    /// we have to dispose all Commands because
    /// they contain a lot of ValueNotifiers
    updateFromApiCommand.dispose();
    completeCommand.dispose();
    uncompleteCommand.dispose();
    super.dispose();
  }
}
