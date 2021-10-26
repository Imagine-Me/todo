import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/logic/bloc/category_bloc.dart';
import 'package:todo/src/presentation/routes/todo_router.dart';

void main() {
  runApp(MyApp(
    todoRouter: TodoRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final TodoRouter todoRouter;

  const MyApp({Key? key, required this.todoRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc(),
      child: MaterialApp(
        title: 'Todo',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/category',
        onGenerateRoute: todoRouter.onGenerateRoute,
      ),
    );
  }
}
