import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
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

  TodoBloc({required this.categoryBloc})
      : super(TodoState(categoryState: CategoryState())) {
    on<GetTodo>((event, emit) {
      print('TODO TABLE CHANGED, EMITING NEW STATE');
      print(_categoryState.colors);
      emit(TodoState(todos: event.todos, categoryState: _categoryState));
    });
    on<AddTodo>((event, _) {
      print('ADDING NEW TODO');
      database.addTodo(event.todosCompanion);
    });
    on<ToggleCompletedTodo>((event, _) {
      print('TOGGLING CHECKBOX');
      database.toggleCompleted(event.todosCompanion);
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
      if (state.todos.isNotEmpty) {
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
