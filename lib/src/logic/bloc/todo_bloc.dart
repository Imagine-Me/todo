import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/src/database/database.dart';
import 'package:todo/src/logic/bloc/category_bloc.dart';
import 'package:todo/src/logic/model/catergory_model.dart';
import 'package:todo/src/logic/model/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final CategoryBloc categoryBloc;
  late final StreamSubscription<List<Todo>> tableStream;
  late final StreamSubscription categoryStream;

  CategoryState _categoryState = CategoryState();
  int? _category;

  TodoBloc({required this.categoryBloc})
      : super(TodoInitial(categoryState: CategoryState())) {
    on<GetTodo>((event, emit) {
      print('TODO TABLE CHANGED, EMITING NEW STATE');
      emit(TodoLoaded(
        todos: event.todos,
        categoryState: _categoryState,
        category: _category,
      ));
    });
    on<AddTodo>((event, _) {
      print('ADDING NEW TODO');
      database.addTodo(event.todosCompanion);
    });
    on<ToggleCompletedTodo>((event, _) {
      print('TOGGLING CHECKBOX');
      database.toggleCompleted(event.todosCompanion);
    });
    on<FilterTodo>((event, emit) {
      print('Filtering the todo');
      _category = event.category;
      final newState = TodoLoaded(
          categoryState: _categoryState,
          todos: state.todos,
          category: event.category);
      emit(newState);
    });
    on<DeleteTodo>((event, _) {
      print('DELETING TODO');
      database.deleteTodo(event.todosCompanion);
    });
    subscribeTodoTable();
    subscribeCategory();
  }

  StreamSubscription<List<Todo>> subscribeTodoTable() {
    return tableStream = database.watchTodos().listen((event) {
      add(GetTodo(todos: event));
    });
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
    tableStream.cancel();
    categoryStream.cancel();
    return super.close();
  }
}
