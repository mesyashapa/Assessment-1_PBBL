import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'todo_bloc.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoPage extends StatelessWidget {
  TodoPage({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Todo App")),
        body: Column(
          children: [
            TextField(controller: controller),
            ElevatedButton(
              onPressed: () {
                context.read<TodoBloc>().add(AddTodo(controller.text));
              },
              child: const Text("Tambah"),
            ),

            Expanded(
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (_, i) {
                      final todo = state.todos[i];
                      return ListTile(
                        title: Text(todo.title),
                        leading: Checkbox(
                          value: todo.isDone,
                          onChanged: (_) {
                            context.read<TodoBloc>().add(ToggleTodo(i));
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}