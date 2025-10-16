// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_item2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoItem2 _$TodoItem2FromJson(Map<String, dynamic> json) => TodoItem2(
  id: json['id'] as String,
  title: json['title'] as String,
  completed: json['completed'] as bool? ?? false,
);

Map<String, dynamic> _$TodoItem2ToJson(TodoItem2 instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'completed': instance.completed,
};
