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
            return const TodoAddingView();
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
                title: Text(
                  item.title,
                  style: item.completed
                      ? const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        )
                      : null,
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
  const TodoAddingView({super.key});

  @override
  State<TodoAddingView> createState() => _TodoAddingViewState();
}

class _TodoAddingViewState extends State<TodoAddingView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: context.l10n.todoAddingViewTextFieldLabel,
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                final newItem = TodoItem(
                  id: '',
                  title: value,
                  completed: false,
                );
                context.read<TodoPageBloc>().add(
                  TodoPageEvent.add(item: newItem),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
