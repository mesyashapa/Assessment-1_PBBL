import 'todo_state.dart'; // WAJIB ADA

abstract class TodoEvent {}

class AddTodo extends TodoEvent {
  final String title;
  AddTodo(this.title);
}

class DeleteTodo extends TodoEvent {
  final String id;
  DeleteTodo(this.id);
}

class ToggleTodo extends TodoEvent {
  final String id;
  ToggleTodo(this.id);
}

class EditTodo extends TodoEvent {
  final String id;
  final String newTitle;

  EditTodo(this.id, this.newTitle);
}

class ChangeFilter extends TodoEvent {
  final Filter filter;
  ChangeFilter(this.filter);
}