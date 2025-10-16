import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_item2.g.dart';

@JsonSerializable()
class TodoItem2 extends Equatable {
  const TodoItem2({
    required this.id,
    required this.title,
    this.completed = false,
  });
  factory TodoItem2.fromJson(Map<String, dynamic> json) =>
      _$TodoItem2FromJson(json);

  final String id;
  final String title;
  final bool completed;

  @override
  List<Object?> get props => [id, title, completed];

  TodoItem2 copyWith({
    String? id,
    String? title,
    bool? completed,
  }) {
    return TodoItem2(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }

  Map<String, dynamic> toJson() => _$TodoItem2ToJson(this);

  @override
  String toString() {
    return 'TodoItem2{id: $id, title: $title, completed: $completed}';
  }
}
