import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/src/database/database.dart';
import 'package:todo/src/logic/bloc/category/category_bloc.dart';
import 'package:todo/src/logic/bloc/todo/todo_bloc.dart';
import 'package:todo/src/logic/bloc/user/user_bloc.dart';
import 'package:todo/src/presentation/screens/home/home.dart';
import 'package:path/path.dart' as p;
import 'package:todo/src/presentation/widgets/animation/todo_loader/todo_loader.dart';

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
    print('TEARING DOWN THE TESTS...');
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'db.sqlite'));
    await file.delete();
  });

  testWidgets('home screen - check for loading screen',
      (WidgetTester tester) async {
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

  testWidgets('home screen - if categories are not check for add category text',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(makeHomeScreen());
      await Future.delayed(const Duration(seconds: 1));
      await tester.pump();
      expect(
        find.text('Categories are required to add task. Create one now!'),
        findsOneWidget,
      );
      await todoBloc.close();
    });
  });

  testWidgets('home screen - empty text for todo when category added',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(makeHomeScreen());
      _categoryBloc.add(
        AddCategory(
          category: const CategoriesCompanion(
            category: Value('office'),
            color: Value('0xff00000'),
          ),
        ),
      );
      await Future.delayed(const Duration(seconds: 1));
      await tester.pump();
      expect(find.text('Wow, such empty!'), findsOneWidget);
      expect(find.byType(TodoLoader), findsOneWidget);
      expect(find.text('office'), findsOneWidget);
      await todoBloc.close();
    });
  });

  testWidgets('home screen - add category', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(makeHomeScreen());
      expect(find.byType(FloatingActionButton), findsOneWidget);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.byType(BottomSheet), findsOneWidget);
      final titleField = find.byKey(const Key('todo_form_title'));
      final remindMeButton = find.byKey(const Key('todo_form_remind_me'));
      final categoryDropdown = find.byKey(const Key('todo_form_category'));
      final submitButton = find.byKey(const Key('todo_form_submit_button'));
      expect(titleField, findsOneWidget);
      expect(remindMeButton, findsOneWidget);
      expect(categoryDropdown, findsOneWidget);
      expect(submitButton, findsOneWidget);

      await tester.enterText(titleField, 'my first todo');
      await tester.tap(submitButton);
      await tester.pump();
      expect(find.text('Please select category'), findsOneWidget);

      await tester.tap(categoryDropdown);
      await tester.pump();
      final dropdownMenus =
          find.descendant(of: categoryDropdown, matching: find.text('office'));
      expect(dropdownMenus, findsWidgets);
      await tester.tap(dropdownMenus);
      await tester.pump();
      expect(
          find.descendant(of: categoryDropdown, matching: find.text('office')),
          findsOneWidget);
      await tester.tap(submitButton);
      await tester.pumpAndSettle();
      expect(find.byType(BottomSheet), findsNothing);
      await Future.delayed(const Duration(seconds: 1));
      await tester.pump();
      expect(find.byType(TodoLoader), findsNothing);
      expect(find.text('my first todo'), findsOneWidget);
      await todoBloc.close();
    });
  });

  testWidgets('home screen - clicking the checkbox',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(makeHomeScreen());
      await Future.delayed(const Duration(seconds: 1));
      await tester.pump();

      final todoList = find.byKey(const Key('todo_list'));
      expect(todoList, findsOneWidget);
      final todoCard =
          find.descendant(of: todoList, matching: find.byType(Dismissible));
      expect(todoCard, findsOneWidget);
      await tester.tap(
        find.descendant(of: todoCard, matching: find.byType(Checkbox)),
      );
      await Future.delayed(const Duration(seconds: 1));
      await tester.pump();
      expect(
          (tester.widget(find.descendant(
                  of: todoCard, matching: find.byType(Checkbox))) as Checkbox)
              .value,
          true);
      await todoBloc.close();
    });
  });

  testWidgets('home screen - swiping left to right make task uncompleted',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(makeHomeScreen());
      await Future.delayed(const Duration(seconds: 1));
      await tester.pump();

      final todoList = find.byKey(const Key('todo_list'));
      expect(todoList, findsOneWidget);
      final todoCard =
          find.descendant(of: todoList, matching: find.byType(Dismissible));
      expect(todoCard, findsOneWidget);
      await tester.drag(todoCard, const Offset(500, 0));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 1));
      await tester.pump();
      expect(
          (tester.widget(find.descendant(
                  of: todoCard, matching: find.byType(Checkbox))) as Checkbox)
              .value,
          false);
      await todoBloc.close();
    });
  });

  testWidgets('home screen - swiping right to left make task completed',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(makeHomeScreen());
      await Future.delayed(const Duration(seconds: 1));
      await tester.pump();

      final todoList = find.byKey(const Key('todo_list'));
      expect(todoList, findsOneWidget);
      final todoCard =
          find.descendant(of: todoList, matching: find.byType(Dismissible));
      expect(todoCard, findsOneWidget);
      await tester.drag(todoCard, const Offset(-500, 0));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 1));
      await tester.pump();
      expect(
          (tester.widget(find.descendant(
                  of: todoCard, matching: find.byType(Checkbox))) as Checkbox)
              .value,
          true);
      await todoBloc.close();
    });
  });

  testWidgets(
      'home screen - clicking on todo card will open up bottomsheet with data and updation',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(makeHomeScreen());
      await Future.delayed(const Duration(seconds: 1));
      await tester.pump();

      final todoList = find.byKey(const Key('todo_list'));
      expect(todoList, findsOneWidget);
      final todoCard =
          find.descendant(of: todoList, matching: find.byType(Dismissible));
      expect(todoCard, findsOneWidget);
      await tester.tap(todoCard);

      await Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.byType(BottomSheet), findsOneWidget);

      final titleField = find.byKey(const Key('todo_form_title'));
      final submitButton = find.byKey(const Key('todo_form_submit_button'));

      expect(
          (titleField.evaluate().single.widget as TextFormField)
              .controller!
              .text,
          'my first todo');
      await tester.enterText(titleField, 'my first todo updated');
      await tester.tap(submitButton);
      await tester.pumpAndSettle();
      expect(find.byType(BottomSheet), findsNothing);
      await Future.delayed(const Duration(seconds: 1));
      await tester.pump();
      expect(find.text('my first todo updated'), findsOneWidget);

      await todoBloc.close();
    });
  });

  testWidgets('home screen- check remind alert is showing',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(makeHomeScreen());
      expect(find.byType(FloatingActionButton), findsOneWidget);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.byType(BottomSheet), findsOneWidget);

      final remindMe = find.byKey(const Key('todo_form_remind_me'));
      expect(remindMe, findsOneWidget);

      await tester.tap(remindMe);
      await Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);

      await todoBloc.close();
    });
  });

  testWidgets('home screen- check filter alert is showing',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(makeHomeScreen());
      final filterButton = find.byKey(const Key('home_filter_button'));
      expect(filterButton, findsOneWidget);

      await tester.tap(filterButton);
      await Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);

      await todoBloc.close();
    });
  });

  testWidgets('home screen - swiping right to left make task deleted if it is already completed',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(makeHomeScreen());
      await Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      final todoList = find.byKey(const Key('todo_list'));
      expect(todoList, findsOneWidget);
      final todoCard =
          find.descendant(of: todoList, matching: find.byType(Dismissible));
      expect(todoCard, findsOneWidget);
      expect(
          (tester.widget(find.descendant(
                  of: todoCard, matching: find.byType(Checkbox))) as Checkbox)
              .value,
          true);
      await tester.drag(todoCard, const Offset(-500, 0));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 1));
      await tester.pump();
      expect(find.byType(TodoLoader), findsOneWidget);
      await todoBloc.close();
    });
  });
}
