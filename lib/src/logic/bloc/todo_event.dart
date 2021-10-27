part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class GetTodo extends TodoEvent {
  final List<Todo> todos;
  GetTodo({
    this.todos = const [],
  });
}

class AddTodo extends TodoEvent {
  final TodosCompanion todosCompanion;
  AddTodo({required this.todosCompanion});
}

class ToggleCompletedTodo extends TodoEvent {
  final TodosCompanion todosCompanion;
  ToggleCompletedTodo({required this.todosCompanion});
}
