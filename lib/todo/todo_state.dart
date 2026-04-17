import 'todo.dart';

class TodoState {
  final List<Todo> todos;

  const TodoState({this.todos = const []});

  TodoState copyWith({
    List<Todo>? todos,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
    );
  }
}