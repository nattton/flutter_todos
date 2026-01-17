import 'package:flutter/material.dart';
import 'package:flutter_todos/features/todos/todo.dart';
import 'package:flutter_todos/features/todos/view_model/todos_view_model.dart';
import 'package:flutter_todos/l10n/l10n.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodosViewModel(),
      child: const TodoView(),
    );
  }
}

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodosViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.status == TodoPageStatus.editing) {
          return const TodoAddingView();
        }

        final l10n = context.l10n;
        final todoItems = viewModel.items;

        return Scaffold(
          appBar: AppBar(title: Text(l10n.todoAppBarTitle)),
          body: ListView.separated(
            itemBuilder: (context, index) {
              final item = todoItems[index];
              return ListTile(
                leading: Checkbox(
                  value: item.completed,
                  onChanged: (value) {
                    context.read<TodosViewModel>().toggleTodo(item.id);
                  },
                ),
                title: InkWell(
                  child: TodoItemView(item: item),
                  onTap: () {
                    context.read<TodosViewModel>().startEditing(item);
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    context.read<TodosViewModel>().removeTodo(item.id);
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
                onPressed: () =>
                    context.read<TodosViewModel>().startNewEditing(),
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
