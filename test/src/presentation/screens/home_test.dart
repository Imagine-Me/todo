import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/src/database/database.dart';
import 'package:todo/src/logic/bloc/category_bloc.dart';
import 'package:todo/src/logic/bloc/todo_bloc.dart';
import 'package:todo/src/logic/bloc/user_bloc.dart';
import 'package:todo/src/presentation/screens/home.dart';
import 'package:path/path.dart' as p;

void main() {
  late CategoryBloc _categoryBloc;
  late TodoBloc todoBloc;

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
    print('SETTING UP TESTS....');
    _categoryBloc = CategoryBloc();
    todoBloc = TodoBloc(categoryBloc: _categoryBloc);
  });
  tearDownAll(() async {
    print('Tearing down the tests...');
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'db.sqlite'));
    await file.delete();
  });

  addInitialCategory() {
    _categoryBloc.add(AddCategory(
        category: const CategoriesCompanion(
            category: Value('office'), color: Value('0xff00000'))));
  }

  testWidgets('home screen', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(makeHomeScreen());
      final categoryFinder = find.text('CATEGORIES');
      final todoFinder = find.text('TODOS ');
      final loadingFinder = find.text('Loading....');
      expect(categoryFinder, findsOneWidget);
      expect(todoFinder, findsOneWidget);
      expect(loadingFinder, findsOneWidget);
      await todoBloc.close();
    });
  });

  testWidgets('should have add category', (WidgetTester tester) async {
    await tester.runAsync(() async {
      _categoryBloc.add(AddCategory(
          category: const CategoriesCompanion(
              category: Value('office'), color: Value('0xff00000'))));
      await tester.pumpWidget(makeHomeScreen());
      expect(find.byType(FloatingActionButton), findsOneWidget);
      await tester.tap(find.byType(FloatingActionButton));
      expect(find.text('Loading....'), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.byType(BottomSheet), findsOneWidget);

      final titleField = find.byKey(const Key('todo_form_title'));
      final submitButton = find.byKey(const Key('todo_form_submit_button'));
      final categoryDropdown = find.byKey(const Key('todo_form_category'));
      expect(titleField, findsOneWidget);
      expect(submitButton, findsOneWidget);
      await tester.enterText(titleField, 'my first todo');
      expect((tester.widget(titleField) as TextFormField).controller!.text,
          'my first todo');
      await tester.tap(submitButton);
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('Please select category'), findsOneWidget);

      await tester.tap(categoryDropdown);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final dropdownMenus =
          find.descendant(of: categoryDropdown, matching: find.text('office'));
      expect(dropdownMenus, findsWidgets);
      await tester.tap(dropdownMenus);
      await tester.pump(const Duration(seconds: 1));
      expect(
          find.descendant(of: categoryDropdown, matching: find.text('office')),
          findsOneWidget);

      await tester.tap(submitButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(find.byType(BottomSheet), findsNothing);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      final todoList = find.byKey(const Key('todo_list'));
      expect(todoList, findsOneWidget);
      final todoCard =
          find.descendant(of: todoList, matching: find.byType(Dismissible));
      expect(todoCard, findsOneWidget);

      print('CLICKING ON CHECK BOX....');

      await tester
          .tap(find.descendant(of: todoCard, matching: find.byType(Checkbox)));

      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      expect(
          (tester.widget(find.descendant(
                  of: todoCard, matching: find.byType(Checkbox))) as Checkbox)
              .value,
          true);

      print('SWIPING LEFT TO RIGHT (IS COMPLETED WILL BE FALSE)');
      await tester.drag(todoCard, const Offset(500, 0));
      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pump(const Duration(milliseconds: 200));
      expect(
          (tester.widget(find.descendant(
                  of: todoCard, matching: find.byType(Checkbox))) as Checkbox)
              .value,
          false);
      print('SWIPING RIGHT TO LEFT (IS COMPLETED WILL BE FALSE)');
      await tester.drag(todoCard, const Offset(-500, 0));
      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pump(const Duration(milliseconds: 200));
      expect(
          (tester.widget(find.descendant(
                  of: todoCard, matching: find.byType(Checkbox))) as Checkbox)
              .value,
          true);

      print('CLICKING ON TODO');
      await tester.tap(todoCard);
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(find.byType(BottomSheet), findsOneWidget);
      expect(find.text('Update'), findsOneWidget);
      expect((tester.widget(titleField) as TextFormField).controller!.text,
          'my first todo');

      await tester.enterText(titleField, 'my first todo updated');
      expect((tester.widget(titleField) as TextFormField).controller!.text,
          'my first todo updated');
      await tester.tap(submitButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(find.byType(BottomSheet), findsNothing);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      print('CHECKING UPDATES WORKS');
      expect(find.text('my first todo updated'), findsOneWidget);
      print('SWIPING RIGHT TO LEFT (ITEM WILL BE DELETED)');
      await tester.drag(todoCard, const Offset(-500, 0));
      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pump(const Duration(milliseconds: 200));
      expect(todoList, findsNothing);
      await todoBloc.close();
    });
  });
}
