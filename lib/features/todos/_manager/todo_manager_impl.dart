import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:flutter_todos/data/services/models/todo_dto.dart';
import 'package:flutter_todos/features/todos/_manager/todo_manager.dart';
import 'package:flutter_todos/features/todos/_models/feed_data_source.dart';
import 'package:flutter_todos/features/todos/_models/todo_proxy.dart';

class TodoManagerImplementation extends TodoManager {
  final FeedDataSource _todosFeed = FeedDataSource();
  @override
  FeedDataSource get todosFeed => _todosFeed;

  late final ValueListenable<bool> _updateFromApiIsExecuting = _todosFeed
      .updateDataCommand
      .isRunning
      .combineLatest(
        _todosFeed.updateDataCommand.isRunning,
        (a, b) => a || b,
      );

  @override
  ValueListenable<bool> get updateFromApiIsExecuting =>
      _updateFromApiIsExecuting;

  /// cache for already proxied todos
  final Map<String, TodoProxy> _proxyRepository = {};

  @override
  List<TodoProxy> createProxies(List<TodoDto> todoDtos) {
    return todoDtos.map(createProxy).toList();
  }

  @override
  TodoProxy createProxy(TodoDto todoDto) {
    if (_proxyRepository.containsKey(todoDto.id)) {
      final existingProxy = _proxyRepository[todoDto.id]!;
      existingProxy.target = todoDto;
      existingProxy.referenceCount++;
      return existingProxy;
    }
    final newProxy = TodoProxy(todoDto);
    newProxy.referenceCount++;
    _proxyRepository[todoDto.id] = newProxy;
    return newProxy;
  }

  @override
  void releaseProxies(List<TodoProxy> proxies) {
    proxies.forEach(releaseProxy);
  }

  @override
  void releaseProxy(TodoProxy proxy) {
    proxy.referenceCount--;
    if (proxy.referenceCount == 0) {
      _proxyRepository.remove(proxy.id);
      proxy.dispose();
    }
  }
}
