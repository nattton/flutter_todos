import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_item.freezed.dart';
part 'todo_item.g.dart';

@freezed
abstract class TodoItem with _$TodoItem {
  const factory TodoItem({
    required String id,
    required String title,
    @Default(false) bool completed,
  }) = _TodoItem;

  factory TodoItem.fromJson(Map<String, Object?> json) =>
      _$TodoItemFromJson(json);

  @override
  Map<String, Object?> toJson() => _$TodoItemToJson(this as _TodoItem);
}
