import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_dto.freezed.dart';
part 'todo_dto.g.dart';

@freezed
abstract class TodoDto with _$TodoDto {
  const factory TodoDto({
    required String id,
    required String title,
    @Default(false) bool completed,
  }) = _TodoDto;

  factory TodoDto.fromJson(Map<String, Object?> json) =>
      _$TodoDtoFromJson(json);

  @override
  Map<String, Object?> toJson() => _$TodoDtoToJson(this as _TodoDto);
}
