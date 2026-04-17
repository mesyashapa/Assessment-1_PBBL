import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';

class HomeScreen extends StatelessWidget {
HomeScreen({super.key});

final TextEditingController controller = TextEditingController();

void showEditDialog(BuildContext context, String id, String oldTitle) {
TextEditingController editController =
TextEditingController(text: oldTitle);


showDialog(
  context: context,
  builder: (_) => AlertDialog(
    title: const Text("Edit Todo"),
    content: TextField(
      controller: editController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text("Batal"),
      ),
      ElevatedButton(
        onPressed: () {
          context
              .read<TodoBloc>()
              .add(EditTodo(id, editController.text));
          Navigator.pop(context);
        },
        child: const Text("Simpan"),
      )
    ],
  ),
);


}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFFF5F5F5),


  appBar: AppBar(
    title: const Text("Todo App"),
    centerTitle: true,
    backgroundColor: Colors.deepPurple,
  ),

  body: BlocListener<TodoBloc, TodoState>(
    listener: (context, state) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Perubahan berhasil disimpan"),
        ),
      );
    },
    child: Column(
      children: [

        // INPUT
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "Tambah todo...",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                mini: true,
                backgroundColor: Colors.deepPurple,
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    context
                        .read<TodoBloc>()
                        .add(AddTodo(controller.text));
                    controller.clear();
                  }
                },
                child: const Icon(Icons.add),
              )
            ],
          ),
        ),

        // FILTER BUTTON
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  filterButton(context, "All", Filter.all, state.filter),
                  filterButton(context, "Done", Filter.done, state.filter),
                  filterButton(context, "Pending", Filter.pending, state.filter),
                ],
              );
            },
          ),
        ),

        const SizedBox(height: 10),

        // LIST TODO
        Expanded(
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {

              var todos = state.todos;

              if (state.filter == Filter.done) {
                todos = todos.where((t) => t.isDone).toList();
              } else if (state.filter == Filter.pending) {
                todos = todos.where((t) => !t.isDone).toList();
              }

              if (todos.isEmpty) {
                return const Center(
                  child: Text(
                    "Belum ada todo",
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: Checkbox(
                        value: todo.isDone,
                        activeColor: Colors.deepPurple,
                        onChanged: (_) {
                          context
                              .read<TodoBloc>()
                              .add(ToggleTodo(todo.id));
                        },
                      ),
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          decoration: todo.isDone
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit,
                                color: Colors.orange),
                            onPressed: () {
                              showEditDialog(
                                  context, todo.id, todo.title);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.red),
                            onPressed: () {
                              context
                                  .read<TodoBloc>()
                                  .add(DeleteTodo(todo.id));
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    ),
  ),
);


}

Widget filterButton(
BuildContext context, String text, Filter filter, Filter activeFilter) {
final isActive = filter == activeFilter;


return ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: isActive ? Colors.deepPurple : Colors.grey,
  ),
  onPressed: () {
    context.read<TodoBloc>().add(ChangeFilter(filter));
  },
  child: Text(
    text,
    style: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
);


}
}
