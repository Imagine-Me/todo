import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/logic/bloc/category/category_bloc.dart';
import 'package:todo/src/logic/bloc/todo/todo_bloc.dart';
import 'package:todo/src/logic/bloc/user/user_bloc.dart';
import 'package:todo/src/presentation/routes/todo_router.dart';
import 'package:todo/src/presentation/theme/theme.dart';
import 'package:todo/src/resources/notification_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationClass notificationClass = NotificationClass();
  await notificationClass.initNotifications();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging instance = FirebaseMessaging.instance;

  String? firebaseToken =
      await instance.getToken(vapidKey: DefaultFirebaseOptions.vapidKey);

  runApp(MyApp(
    todoRouter: TodoRouter(),
    firebaseToken: firebaseToken,
  ));
}

class MyApp extends StatelessWidget {
  final TodoRouter todoRouter;
  final String? firebaseToken;
  final CategoryBloc _categoryBloc = CategoryBloc();

  MyApp({Key? key, required this.todoRouter, this.firebaseToken})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(firebaseToken: firebaseToken),
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
