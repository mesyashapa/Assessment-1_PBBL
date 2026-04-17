import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'todo_event.dart';
import 'todo_state.dart';
import 'todo.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {

    on<LoadTodo>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getStringList("todos") ?? [];

      final todos = data.map((e) {
        final split = e.split("|");
        return Todo(split[0], isDone: split[1] == "true");
      }).toList();

      emit(state.copyWith(todos: todos));
    });

    on<AddTodo>((event, emit) async {
      final updated = [...state.todos, Todo(event.title)];
      emit(state.copyWith(todos: updated));
      await save(updated);
    });

    on<ToggleTodo>((event, emit) async {
      final list = List<Todo>.from(state.todos);
      list[event.index].isDone = !list[event.index].isDone;
      emit(state.copyWith(todos: list));
      await save(list);
    });

  }

  Future<void> save(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final data = todos.map((e) => "${e.title}|${e.isDone}").toList();
    await prefs.setStringList("todos", data);
  }
}