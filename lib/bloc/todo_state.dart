import '../models/todo.dart';

enum Filter { all, done, pending }

class TodoState {
  final List<Todo> todos;
  final Filter filter;

  TodoState(this.todos, this.filter);
}