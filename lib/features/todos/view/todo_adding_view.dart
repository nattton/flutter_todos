import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:flutter_todos/features/todos/view_model/todos_view_model.dart';
import 'package:flutter_todos/l10n/l10n.dart';
import 'package:provider/provider.dart';

class TodoAddingView extends WatchingWidget {
  const TodoAddingView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final editingId = context.read<TodosViewModel>().editingId;
    final editingTitle = context.read<TodosViewModel>().editingTitle;
    final textController = createOnce(
      () => TextEditingController(text: editingTitle),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          editingTitle.isNotEmpty
              ? l10n.todoAddingViewAppBarTitleEdit
              : l10n.todoAddingViewAppBarTitleAdd,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            TextField(
              controller: textController,
              autofocus: true,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: context.l10n.todoAddingViewTextFieldLabel,
              ),
              onChanged: (value) {
                context.read<TodosViewModel>().setEditingTitle(value);
              },
              onSubmitted: (value) {
                context.read<TodosViewModel>().saveTodo();
              },
            ),
            OutlinedButton(
              onPressed: () {
                context.read<TodosViewModel>().saveTodo();
              },
              child: Text(
                editingId.isNotEmpty
                    ? l10n.todoAddingViewButtonUpdate
                    : l10n.todoAddingViewButtonSave,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 26,
        children: [
          FloatingActionButton(
            onPressed: () => context.read<TodosViewModel>().stopEditing(),
            child: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
