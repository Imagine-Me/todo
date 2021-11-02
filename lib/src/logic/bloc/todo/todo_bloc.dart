import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo/src/database/database.dart';
import 'package:todo/src/logic/bloc/category/category_bloc.dart';
import 'package:todo/src/logic/model/catergory_model.dart';
import 'package:todo/src/logic/model/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final CategoryBloc categoryBloc;
  late final StreamSubscription categoryStream;

  CategoryState _categoryState = CategoryState();
  int? _category;

  TodoBloc({required this.categoryBloc})
      : super(TodoInitial(categoryState: CategoryState())) {
    on<GetTodo>((event, emit) {
      print('EMITING TODO ${event.todos}');
      emit(TodoLoaded(
        todos: event.todos,
        categoryState: _categoryState,
        category: _category,
      ));
    });
    on<AddTodo>((event, _) async {
      await database.addTodo(event.todosCompanion);
      getTodos();
    });
    on<ToggleCompletedTodo>((event, _) async {
      await database.toggleCompleted(event.todosCompanion);
      getTodos();
    });
    on<FilterTodo>((event, emit) {
      _category = event.category;
      final newState = TodoLoaded(
          categoryState: _categoryState,
          todos: state.todos,
          category: event.category);
      emit(newState);
    });
    on<DeleteTodo>((event, _) async {
      await database.deleteTodo(event.todosCompanion);
      getTodos();
    });
    // subscribeTodoTable();
    getTodos();
    subscribeCategory();
  }

  Future<void> getTodos() async {
    final List<Todo> todos = await database.getTodos();
    add(GetTodo(todos: todos));
  }

  void subscribeCategory() {
    categoryStream = categoryBloc.stream.listen((event) {
      _categoryState = event;
      if (state is TodoLoaded) {
        add(GetTodo(todos: state.todos));
      }
    });
  }

  @override
  Future<void> close() {
    categoryStream.cancel();
    return super.close();
  }
}
