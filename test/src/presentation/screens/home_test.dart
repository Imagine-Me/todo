import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/src/logic/bloc/category_bloc.dart';
import 'package:todo/src/logic/bloc/todo_bloc.dart';
import 'package:todo/src/logic/bloc/user_bloc.dart';
import 'package:todo/src/presentation/screens/home.dart';

void main() {
  late final CategoryBloc _categoryBloc;
  late final TodoBloc todoBloc;

  Widget makeHomeScreen() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
        BlocProvider<CategoryBloc>(
          create: (context) => _categoryBloc,
        ),
        BlocProvider<TodoBloc>(
          create: (context) => todoBloc,
        ),
      ],
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }

  setUp(() {
    _categoryBloc = CategoryBloc();
    todoBloc = TodoBloc(categoryBloc: _categoryBloc);
  });

  // testWidgets('home screen', (WidgetTester tester) async {
  //   await tester.pumpWidget(makeHomeScreen());
  // });
}
