import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:todo/src/constants/enum.dart';
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
  tearDown((){
    categoryBloc.close();
    todoBloc.close();
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
        todosCompanion: TodosCompanion(
            category: const Value(1),
            title: const Value('first todo'),
            isCreatedAt: Value(DateTime.now())),
      ),
    ),
    expect: () => [
      TodoLoaded(
          categoryState: categoryBloc.state,
          todoFilter: TodoFilter(null, OrderTypes.created),
          todos: [
            Todo(
              id: 1,
              title: 'first todo',
              isCompleted: false,
              remindAt: null,
            ),
          ])
    ],
  );
  blocTest(
    'Adding second todo and check the order is correct',
    build: () => todoBloc,
    act: (_) => todoBloc.add(AddTodo(
      todosCompanion: TodosCompanion(
        category: const Value(1),
        isCompleted: const Value(true),
        title: const Value('second todo'),
        isCreatedAt: Value(DateTime.now().add(const Duration(seconds: 1))),
      ),
    )),
    expect: () => [
      isA<TodoLoaded>(),
      TodoLoaded(
        categoryState: categoryBloc.state,
        todoFilter: TodoFilter(null, OrderTypes.created),
        todos: [
          Todo(
            id: 1,
            title: 'first todo',
            isCompleted: false,
            remindAt: null,
          ),
          Todo(
            id: 2,
            title: 'second todo',
            isCompleted: true,
            remindAt: null,
          ),
        ],
      ),
    ],
  );

  blocTest(
    'Adding third todo and check the order is correct',
    build: () => todoBloc,
    act: (_) => todoBloc.add(AddTodo(
      todosCompanion: TodosCompanion(
        category: const Value(2),
        title: const Value('third todo'),
        isCreatedAt: Value(DateTime.now().add(const Duration(seconds: 2))),
      ),
    )),
    expect: () => [
      TodoLoaded(
        categoryState: categoryBloc.state,
        todoFilter: TodoFilter(null, OrderTypes.created),
        todos: [
          Todo(
            id: 3,
            title: 'third todo',
            isCompleted: false,
            remindAt: null,
          ),
          Todo(
            id: 1,
            title: 'first todo',
            isCompleted: false,
            remindAt: null,
          ),
          Todo(
            id: 2,
            title: 'second todo',
            isCompleted: true,
            remindAt: null,
          ),
        ],
      ),
    ],
  );

  blocTest(
    'Unompleting a task',
    build: () => todoBloc,
    act: (_) => todoBloc.add(ToggleCompletedTodo(
      todosCompanion: const TodosCompanion(
          id: Value(2), isCompleted: Value(false), title: Value('second todo')),
    )),
    expect: () => [
      isA<TodoLoaded>(),
      TodoLoaded(
        categoryState: categoryBloc.state,
        todoFilter: TodoFilter(null, OrderTypes.created),
        todos: [
          Todo(
            id: 3,
            title: 'third todo',
            isCompleted: false,
            remindAt: null,
          ),
          Todo(
            id: 2,
            title: 'second todo',
            isCompleted: false,
            remindAt: null,
          ),
          Todo(
            id: 1,
            title: 'first todo',
            isCompleted: false,
            remindAt: null,
          ),
        ],
      ),
    ],
  );

  blocTest(
    'Adding fourth todo and check the order is correct',
    build: () => todoBloc,
    act: (_) => todoBloc.add(AddTodo(
      todosCompanion: TodosCompanion(
        category: const Value(2),
        title: const Value('fourth todo'),
        isCreatedAt: Value(DateTime.now().add(const Duration(seconds: 5))),
      ),
    )),
    expect: () => [
      TodoLoaded(
        categoryState: categoryBloc.state,
        todoFilter: TodoFilter(null, OrderTypes.created),
        todos: [
          Todo(
            id: 4,
            title: 'fourth todo',
            isCompleted: false,
            remindAt: null,
          ),
          Todo(
            id: 3,
            title: 'third todo',
            isCompleted: false,
            remindAt: null,
          ),
          Todo(
            id: 2,
            title: 'second todo',
            isCompleted: false,
            remindAt: null,
          ),
          Todo(
            id: 1,
            title: 'first todo',
            isCompleted: false,
            remindAt: null,
          ),
        ],
      ),
    ],
  );

  blocTest(
    'filter based on category',
    build: () => todoBloc,
    act: (_) => todoBloc.add(
      FilterTodo(keyword: '', category: 2),
    ),
    expect: () => [
      isA<TodoLoaded>(),
      TodoLoaded(
        categoryState: categoryBloc.state,
        todoFilter: TodoFilter(null, OrderTypes.created),
        category: 2,
        todos: [
          Todo(
            id: 4,
            title: 'fourth todo',
            isCompleted: false,
            remindAt: null,
          ),
          Todo(
            id: 3,
            title: 'third todo',
            isCompleted: false,
            remindAt: null,
          ),
          Todo(
            id: 2,
            title: 'second todo',
            isCompleted: false,
            remindAt: null,
          ),
          Todo(
            id: 1,
            title: 'first todo',
            isCompleted: false,
            remindAt: null,
          ),
        ],
      ),
    ],
  );

  blocTest('completed a task',
      build: () => todoBloc,
      act: (_) => todoBloc.add(
            ToggleCompletedTodo(
              todosCompanion: const TodosCompanion(
                id: Value(2),
                title: Value('second todo'),
                isCompleted: Value(true),
              ),
            ),
          ),
      expect: () => [
            isA<TodoLoaded>(),
            TodoLoaded(
              categoryState: categoryBloc.state,
              todoFilter: TodoFilter(null, OrderTypes.created),
              todos: [
                Todo(
                  id: 4,
                  title: 'fourth todo',
                  isCompleted: false,
                  remindAt: null,
                ),
                Todo(
                  id: 3,
                  title: 'third todo',
                  isCompleted: false,
                  remindAt: null,
                ),
                Todo(
                  id: 1,
                  title: 'first todo',
                  isCompleted: false,
                  remindAt: null,
                ),
                Todo(
                  id: 2,
                  title: 'second todo',
                  isCompleted: true,
                  remindAt: null,
                ),
              ],
            ),
          ]);

  blocTest(
    'filter based on completed',
    build: () => todoBloc,
    act: (_) async => todoBloc.add(
      TodoFilter(true, OrderTypes.created),
    ),
    expect: () => [
      TodoLoaded(
        categoryState: categoryBloc.state,
        todoFilter: TodoFilter(true, OrderTypes.created),
        todos: [
          Todo(
            id: 2,
            title: 'second todo',
            isCompleted: true,
            remindAt: null,
          ),
        ],
      ),
      isA<TodoLoaded>()
    ],
  );

  blocTest(
    'filter based on uncompleted',
    build: () => todoBloc,
    act: (_) async => todoBloc.add(
      TodoFilter(false, OrderTypes.created),
    ),
    expect: () => [
      TodoLoaded(
        categoryState: categoryBloc.state,
        todoFilter: TodoFilter(false, OrderTypes.created),
        todos: [
          Todo(
            id: 4,
            title: 'fourth todo',
            isCompleted: false,
            remindAt: null,
          ),
          Todo(
            id: 3,
            title: 'third todo',
            isCompleted: false,
            remindAt: null,
          ),
          Todo(
            id: 1,
            title: 'first todo',
            isCompleted: false,
            remindAt: null,
          ),
        ],
      ),
      isA<TodoLoaded>()
    ],
  );

  blocTest(
    'delete todo',
    build: () => todoBloc,
    act: (_) => todoBloc.add(
      DeleteTodo(todosCompanion: const TodosCompanion(id: Value(3))),
    ),
    expect: () => [
      TodoLoaded(
        categoryState: categoryBloc.state,
        todoFilter: TodoFilter(null, OrderTypes.created),
        todos: [
          Todo(
            id: 4,
            title: 'fourth todo',
            isCompleted: false,
            remindAt: null,
          ),
          Todo(
            id: 1,
            title: 'first todo',
            isCompleted: false,
            remindAt: null
          ),
          Todo(
            id: 2,
            title: 'second todo',
            isCompleted: true,
            remindAt: null,
          ),
        ],
      ),
    ],
  );
}
