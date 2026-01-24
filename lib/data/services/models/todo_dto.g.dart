// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file

part of 'todo_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoDtoAdapter extends TypeAdapter<TodoDto> {
  @override
  final typeId = 0;

  @override
  TodoDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoDto(
      id: fields[0] as String,
      title: fields[1] as String,
      completed: !(fields[2] == null) && fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TodoDto obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.completed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TodoDto _$TodoDtoFromJson(Map<String, dynamic> json) => _TodoDto(
  id: json['id'] as String,
  title: json['title'] as String,
  completed: json['completed'] as bool? ?? false,
);

Map<String, dynamic> _$TodoDtoToJson(_TodoDto instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'completed': instance.completed,
};
