import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive_ce.dart';

part 'todo_dto.freezed.dart';
part 'todo_dto.g.dart';

@freezed
@HiveType(typeId: 0)
abstract class TodoDto with _$TodoDto {
  const factory TodoDto({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) @Default(false) bool completed,
  }) = _TodoDto;

  factory TodoDto.fromJson(Map<String, Object?> json) =>
      _$TodoDtoFromJson(json);

  @override
  Map<String, Object?> toJson() => _$TodoDtoToJson(this as _TodoDto);
}
