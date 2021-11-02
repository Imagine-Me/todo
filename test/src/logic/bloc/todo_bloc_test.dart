import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:todo/src/database/database.dart';
import 'package:todo/src/logic/bloc/category/category_bloc.dart';
import 'package:todo/src/logic/bloc/todo/todo_bloc.dart';

void main() {
  late CategoryBloc categoryBloc;
  late TodoBloc todoBloc;
  setUp(() {
    print('INITIALIZING TESTS.....');
    categoryBloc = CategoryBloc();
    todoBloc = TodoBloc(categoryBloc: categoryBloc);
  });

  tearDownAll(() async {
    print('TEARING DOWN THE TESTS...');
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'db.sqlite'));
    await file.delete();
  });

  test('initial state', () {
    expect(todoBloc.state, isA<TodoInitial>());
    expectLater(todoBloc.stream, emitsInOrder([isA<TodoLoaded>()]));
  });
  blocTest(
    'first state',
    build: () => todoBloc,
    act: (_) => todoBloc.add(
      AddTodo(
          todosCompanion: const TodosCompanion(
              category: Value(1), title: Value('first todo'))),
    ),
    expect: () => [
      TodoLoaded(todos: [], categoryState: categoryBloc.state),
      TodoLoaded(categoryState: categoryBloc.state, todos: [
        Todo(id: 1, title: 'first todo', isCompleted: false, remindAt: null)
      ])
    ],
  );

  blocTest(
    'Adding second state to check ordering',
    build: () => todoBloc,
    act: (_) => todoBloc.add(
      AddTodo(
          todosCompanion: const TodosCompanion(
              category: Value(2), title: Value('second todo'))),
    ),
    expect: () => [
      TodoLoaded(
          categoryState: categoryBloc.state,
          todos: [Todo(id: 1, title: 'first todo', isCompleted: false)]),
      TodoLoaded(categoryState: categoryBloc.state, todos: [
        Todo(id: 2, title: 'second todo', isCompleted: false),
        Todo(id: 1, title: 'first todo', isCompleted: false)
      ])
    ],
  );

  blocTest('toggling is completed',
      build: () => todoBloc,
      act: (_) => todoBloc.add(
            ToggleCompletedTodo(
              todosCompanion: const TodosCompanion(
                  id: Value(1),
                  isCompleted: Value(true),
                  title: Value('first todo')),
            ),
          ),
      expect: () => [
            TodoLoaded(categoryState: categoryBloc.state, todos: [
              Todo(id: 2, title: 'second todo', isCompleted: false),
              Todo(id: 1, title: 'first todo', isCompleted: false)
            ]),
            TodoLoaded(categoryState: categoryBloc.state, todos: [
              Todo(id: 2, title: 'second todo', isCompleted: false),
              Todo(id: 1, title: 'first todo', isCompleted: true)
            ]),
          ]);

  blocTest('delete todo',
      build: () => todoBloc,
      act: (_) => todoBloc.add(
            DeleteTodo(todosCompanion: const TodosCompanion(id: Value(2))),
          ),
      expect: () => [
            TodoLoaded(categoryState: categoryBloc.state, todos: [
              Todo(id: 2, title: 'second todo', isCompleted: false),
              Todo(id: 1, title: 'first todo', isCompleted: true)
            ]),
            TodoLoaded(
                categoryState: categoryBloc.state,
                todos: [Todo(id: 1, title: 'first todo', isCompleted: true)]),
          ]);
}
