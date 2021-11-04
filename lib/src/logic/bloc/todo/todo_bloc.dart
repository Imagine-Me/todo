import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo/src/database/database.dart';
import 'package:todo/src/logic/bloc/category/category_bloc.dart';
import 'package:todo/src/logic/model/catergory_model.dart';
import 'package:todo/src/logic/model/todo_model.dart';
import 'package:todo/src/resources/notification_helper.dart';

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
      emit(TodoLoaded(
        todos: event.todos,
        categoryState: _categoryState,
        category: _category,
      ));
    });
    on<AddTodo>((event, _) async {
      TodosCompanion todosCompanion = event.todosCompanion;

      //* CHECK IF NOTIFICATION ALREADY EXISTS
      if (todosCompanion.notification.value != null) {
        final int notificationId = todosCompanion.notification.value!;
        if (todosCompanion.remindAt.value == null) {
          await NotificationClass.flutterLocalNotificationsPlugin
              .cancel(notificationId);
          todosCompanion =
              todosCompanion.copyWith(notification: const Value(null));
          try {
            await database.deleteNotification(
                NotificationsCompanion(id: Value(notificationId)));
          } catch (err) {}
        } else {
          final notification = await database.getNotification(notificationId);
          //* CHECK IF REMINDMETIME IS SAME OR NOT
          if (todosCompanion.remindAt.value != notification.remindAt) {
            await NotificationClass.flutterLocalNotificationsPlugin
                .cancel(notificationId);
            final NotificationsCompanion notificationsCompanion = notification
                .toCompanion(true)
                .copyWith(
                    remindAt: todosCompanion.remindAt,
                    todo: todosCompanion.title,
                    category: todosCompanion.category);
            await database.addNotification(notificationsCompanion);
            setNotification(notificationId, todosCompanion.title.value,
                todosCompanion.remindAt.value!);
          }
        }
      } else {
        if (todosCompanion.remindAt.value != null) {
          final int notification = await database.addNotification(
            NotificationsCompanion(
                todo: todosCompanion.title,
                category: todosCompanion.category,
                remindAt: todosCompanion.remindAt),
          );
          todosCompanion =
              todosCompanion.copyWith(notification: Value(notification));

          setNotification(notification, todosCompanion.title.value,
              todosCompanion.remindAt.value!);
        }
      }

      await database.addTodo(todosCompanion);
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
      if (event.todosCompanion.notification.value != null) {
        await NotificationClass.flutterLocalNotificationsPlugin
            .cancel(event.todosCompanion.notification.value!);
        await database.deleteNotification(NotificationsCompanion(
            id: Value(event.todosCompanion.notification.value!)));
      }
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

  void setNotification(int id, String body, DateTime schedule) {
    scheduleNotification(
        id: id, title: 'Reminder', body: body, scheduledTime: schedule);
  }

  @override
  Future<void> close() {
    categoryStream.cancel();
    return super.close();
  }
}
