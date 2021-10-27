import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/database/database.dart';
import 'package:todo/src/logic/bloc/category_bloc.dart';
import 'package:todo/src/logic/bloc/todo_bloc.dart';
import 'package:todo/src/presentation/routes/todo_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        BlocProvider<CategoryBloc>(
          create: (context) => _categoryBloc,
        ),
        BlocProvider<TodoBloc>(
          create: (context) => TodoBloc(categoryBloc: _categoryBloc),
        ),
      ],
      child: MaterialApp(
        title: 'Todo',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        onGenerateRoute: todoRouter.onGenerateRoute,
      ),
    );
  }
}
