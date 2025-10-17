import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/l10n/l10n.dart';
import 'package:flutter_todos/todo/todo.dart';

class TodoAddingView extends StatefulWidget {
  const TodoAddingView({required this.item, super.key});

  final TodoItem? item;

  @override
  State<TodoAddingView> createState() => _TodoAddingViewState();
}

class _TodoAddingViewState extends State<TodoAddingView> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (widget.item != null) {
      _textController.text = widget.item!.title;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.item != null
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
              controller: _textController,
              autofocus: true,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: context.l10n.todoAddingViewTextFieldLabel,
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  final newItem = TodoItem(
                    id: widget.item?.id ?? '',
                    title: value,
                  );
                  context.read<TodoPageBloc>().add(
                    TodoPageEvent.save(item: newItem),
                  );
                }
              },
            ),
            OutlinedButton(
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  final newItem = TodoItem(
                    id: widget.item?.id ?? '',
                    title: _textController.text,
                  );
                  context.read<TodoPageBloc>().add(
                    TodoPageEvent.save(item: newItem),
                  );
                }
              },
              child: const Text('Save'),
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
            onPressed: () => context.read<TodoPageBloc>().add(
              const TodoPageEvent.listing(),
            ),
            child: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
