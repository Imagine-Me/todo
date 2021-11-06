import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo/src/logic/bloc/category/category_bloc.dart';
import 'package:todo/src/logic/bloc/todo/todo_bloc.dart';
import 'package:todo/src/logic/bloc/user/user_bloc.dart';
import 'package:todo/src/presentation/routes/todo_router.dart';
import 'package:todo/src/presentation/theme/theme.dart';
import 'package:todo/src/resources/notification_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationClass notificationClass = NotificationClass();
  await notificationClass.initNotifications();

  runApp(MyApp(
    todoRouter: TodoRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final TodoRouter todoRouter;
  final CategoryBloc _categoryBloc = CategoryBloc();

  MyApp({Key? key, required this.todoRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
        BlocProvider<CategoryBloc>(
          create: (context) => _categoryBloc,
        ),
        BlocProvider<TodoBloc>(
          create: (context) => TodoBloc(categoryBloc: _categoryBloc),
        ),
      ],
      child: MaterialApp(
        title: 'Todo',
        theme: AppTheme.appTheme(),
        initialRoute: '/',
        onGenerateRoute: todoRouter.onGenerateRoute,
      ),
    );
  }
}
