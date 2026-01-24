import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todos/bootstrap.dart';

void main() {
  testWidgets('bootstrap renders the widget returned by the builder', (
    tester,
  ) async {
    await bootstrap(() => const SizedBox(key: Key('test_widget')));
    await tester.pump();
    expect(find.byKey(const Key('test_widget')), findsOneWidget);
  });

  testWidgets('bootstrap sets FlutterError.onError', (tester) async {
    final originalOnError = FlutterError.onError;
    await bootstrap(() => const SizedBox());
    expect(FlutterError.onError, isNot(equals(originalOnError)));
  });
}
