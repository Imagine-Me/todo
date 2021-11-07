part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class GetTodo extends TodoEvent {
  final List<Todo> todos;
  final int? category;
  final String? keyword;
  GetTodo({this.todos = const [], this.category, this.keyword});
}

class FilterTodo extends TodoEvent {
  final int? category;
  final String keyword;
  FilterTodo({this.category, required this.keyword});
}

class AddTodo extends TodoEvent {
  final TodosCompanion todosCompanion;
  AddTodo({required this.todosCompanion});
}

class ToggleCompletedTodo extends TodoEvent {
  final TodosCompanion todosCompanion;
  ToggleCompletedTodo({required this.todosCompanion});
}

class DeleteTodo extends TodoEvent {
  final TodosCompanion todosCompanion;

  DeleteTodo({required this.todosCompanion});
}

class TodoFilter extends TodoEvent {
  final bool? filterBycompleted;
  final OrderTypes orderTypes;

  TodoFilter(this.filterBycompleted, this.orderTypes);
}
