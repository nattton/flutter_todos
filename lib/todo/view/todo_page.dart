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
    return BlocBuilder<TodoPageBloc, TodoPageState>(
      builder: (context, state) {
        if (todoPageStatus == TodoPageStatus.editing) {
          return TodoAddingView(item: state.editingItem);
        }
        final todoItems = state.items;
        return Scaffold(
          appBar: AppBar(title: Text(l10n.todoAppBarTitle)),
          body: ListView.separated(
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
                  child: TodoItemView(item: item),
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
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 26,
            children: [
              FloatingActionButton(
                onPressed: () => context.read<TodoPageBloc>().add(
                  const TodoPageEvent.editing(
                    item: TodoItem(id: '', title: ''),
                  ),
                ),
                child: const Icon(Icons.text_fields),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TodoItemView extends StatelessWidget {
  const TodoItemView({
    required this.item,
    super.key,
  });

  final TodoItem item;

  @override
  Widget build(BuildContext context) {
    return Text(
      item.title,
      style: item.completed
          ? const TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
            )
          : null,
    );
  }
}
