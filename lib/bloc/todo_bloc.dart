import 'package:flutter_bloc/flutter_bloc.dart';
import 'todo_event.dart';
import 'todo_state.dart';
import '../models/todo.dart';
import 'package:uuid/uuid.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState([], Filter.all)) {

    // ADD
    on<AddTodo>((event, emit) {
      final newTodo = Todo(
        id: Uuid().v4(), // ❌ hapus const
        title: event.title,
      );

      emit(TodoState([...state.todos, newTodo], state.filter));
    });

    // DELETE
    on<DeleteTodo>((event, emit) {
      emit(TodoState(
        state.todos.where((t) => t.id != event.id).toList(),
        state.filter,
      ));
    });

    // TOGGLE
    on<ToggleTodo>((event, emit) {
      final updated = state.todos.map((t) {
        if (t.id == event.id) {
          return t.copyWith(isDone: !t.isDone);
        }
        return t;
      }).toList();

      emit(TodoState(updated, state.filter));
    });

    // EDIT
    on<EditTodo>((event, emit) {
      final updated = state.todos.map((todo) {
        if (todo.id == event.id) {
          return todo.copyWith(title: event.newTitle);
        }
        return todo;
      }).toList();

      emit(TodoState(updated, state.filter));
    });

    // FILTER
    on<ChangeFilter>((event, emit) {
      emit(TodoState(state.todos, event.filter));
    });

  }
}