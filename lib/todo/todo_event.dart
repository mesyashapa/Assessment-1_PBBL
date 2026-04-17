abstract class TodoEvent {}

// LOAD DATA (penting untuk ambil dari local storage)
class LoadTodo extends TodoEvent {}

// TAMBAH TODO
class AddTodo extends TodoEvent {
final String title;

AddTodo(this.title);
}

// TOGGLE (centang / uncentang)
class ToggleTodo extends TodoEvent {
final int index;

ToggleTodo(this.index);
}

