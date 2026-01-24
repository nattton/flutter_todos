import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todos/features/todos/view/todo_adding_view.dart';
import 'package:flutter_todos/features/todos/view_model/todos_view_model.dart';
import 'package:flutter_todos/l10n/l10n.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockTodosViewModel extends Mock implements TodosViewModel {}

void main() {
  group('TodoAddingView', () {
    late TodosViewModel viewModel;

    setUp(() {
      viewModel = MockTodosViewModel();
      when(() => viewModel.editingId).thenReturn('');
      when(() => viewModel.editingTitle).thenReturn('');
      when(() => viewModel.saveTodo()).thenAnswer((_) async {});
      when(() => viewModel.stopEditing()).thenAnswer((_) {});
      when(() => viewModel.setEditingTitle(any())).thenAnswer((_) {});
    });

    Widget buildSubject() {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ChangeNotifierProvider.value(
          value: viewModel,
          child: const TodoAddingView(),
        ),
      );
    }

    testWidgets('renders Add Todo title when editingId is empty', (
      tester,
    ) async {
      await tester.pumpWidget(buildSubject());

      expect(find.text('Adding todo'), findsOneWidget); // Checks AppBar title
      expect(find.text('Save'), findsOneWidget); // Checks Button text
    });

    testWidgets('renders Edit Todo title when editingId is not empty', (
      tester,
    ) async {
      when(() => viewModel.editingId).thenReturn('1');
      when(() => viewModel.editingTitle).thenReturn('Existing Todo');

      await tester.pumpWidget(buildSubject());

      expect(find.text('Editing todo'), findsOneWidget);
      expect(find.text('Update'), findsOneWidget);
      expect(
        find.text('Existing Todo'),
        findsOneWidget,
      ); // Checks TextField content
    });

    testWidgets('entering text calls setEditingTitle', (tester) async {
      await tester.pumpWidget(buildSubject());

      await tester.enterText(find.byType(TextField), 'New Todo');

      verify(() => viewModel.setEditingTitle('New Todo')).called(1);
    });

    testWidgets('submitting text field calls saveTodo', (tester) async {
      await tester.pumpWidget(buildSubject());

      await tester.enterText(find.byType(TextField), 'New Todo');
      await tester.testTextInput.receiveAction(TextInputAction.done);

      verify(() => viewModel.saveTodo()).called(1);
    });

    testWidgets('pressing save button calls saveTodo', (tester) async {
      await tester.pumpWidget(buildSubject());

      await tester.tap(find.byType(OutlinedButton));

      verify(() => viewModel.saveTodo()).called(1);
    });

    testWidgets('pressing close button calls stopEditing', (tester) async {
      await tester.pumpWidget(buildSubject());

      await tester.tap(find.byType(FloatingActionButton));

      verify(() => viewModel.stopEditing()).called(1);
    });
  });
}
