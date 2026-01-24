import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todos/data/services/models/todo_dto.dart';

void main() {
  group('TodoDto', () {
    const id = '1';
    const title = 'Test';
    const completed = true;
    const todoDto = TodoDto(id: id, title: title, completed: completed);
    final json = <String, dynamic>{
      'id': id,
      'title': title,
      'completed': completed,
    };

    test('supports value equality', () {
      expect(
        const TodoDto(id: id, title: title, completed: completed),
        equals(todoDto),
      );
    });

    test('fromJson returns correct object', () {
      expect(TodoDto.fromJson(json), equals(todoDto));
    });

    test('toJson returns correct json', () {
      expect(todoDto.toJson(), equals(json));
    });
  });
}
