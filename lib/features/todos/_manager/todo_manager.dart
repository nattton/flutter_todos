import 'package:flutter/foundation.dart';
import 'package:flutter_todos/data/services/models/todo_dto.dart';
import 'package:flutter_todos/features/todos/_models/feed_data_source.dart';
import 'package:flutter_todos/features/todos/_models/todo_proxy.dart';

abstract class TodoManager {
  /// create a proxy from a TodoDto
  /// if the TodoDto is already proxied, it will return the existing proxy
  TodoProxy createProxy(TodoDto todoDto);

  /// create a list of proxies from a list of TodoDto
  /// if the TodoDto is already proxied, it will return the existing proxy
  List<TodoProxy> createProxies(List<TodoDto> todoDtos);
  void releaseProxies(List<TodoProxy> proxies);
  void releaseProxy(TodoProxy proxy);

  /// To show the flexibilty of declarative logic with commands we will
  /// block that you can all any command to update the data from the api
  /// while any update is in progress
  ValueListenable<bool> get updateFromApiIsExecuting;

  /// this class would normally contain the business logic for the todos feature
  /// like creating, or deleting todos, for the first part of the tutorial
  /// whis will only contain the factory for the FeedDataSources
  ///
  ///
  /// all todos
  FeedDataSource get todosFeed;
}
