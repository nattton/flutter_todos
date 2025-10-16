import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/l10n/l10n.dart';
import 'package:flutter_todos/todo/todo.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoPageBloc(),
      child: const TodoView(),
    );
  }
}

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final todoPageStatus = context.select(
      (TodoPageBloc bloc) => bloc.state.status,
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.todoAppBarTitle)),
      body: BlocBuilder<TodoPageBloc, TodoPageState>(
        builder: (context, state) {
          if (todoPageStatus == TodoPageStatus.adding) {
            return const TodoAddingView(item: null);
          }

          if (todoPageStatus == TodoPageStatus.editing) {
            return TodoAddingView(item: state.editingItem);
          }

          final todoItems = state.items;
          return ListView.separated(
            itemBuilder: (context, index) {
              final item = todoItems[index];
              return ListTile(
                leading: Checkbox(
                  value: item.completed,
                  onChanged: (value) {
                    context.read<TodoPageBloc>().add(
                      TodoPageEvent.toggleComplete(id: item.id),
                    );
                  },
                ),
                title: InkWell(
                  child: Text(
                    item.title,
                    style: item.completed
                        ? const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          )
                        : null,
                  ),
                  onTap: () {
                    context.read<TodoPageBloc>().add(
                      TodoPageEvent.editing(item: item),
                    );
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    context.read<TodoPageBloc>().add(
                      TodoPageEvent.remove(id: item.id),
                    );
                  },
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: todoItems.length,
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (todoPageStatus != TodoPageStatus.adding)
            FloatingActionButton(
              onPressed: () => context.read<TodoPageBloc>().add(
                const TodoPageEvent.adding(),
              ),
              child: const Icon(Icons.add),
            ),
          if (todoPageStatus == TodoPageStatus.adding)
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
    if (widget.item != null) {
      _textController.text = widget.item!.title;
    }
    return Padding(
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
    );
  }
}
