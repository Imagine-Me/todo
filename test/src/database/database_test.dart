import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/src/database/database.dart';

void main() {
  late TodoTable todoTable;
  setUp(() {
    todoTable = TodoTable(e: NativeDatabase.memory());
  });

  tearDown(() async {
    await todoTable.close();
  });
  group('User table', () {
    test('add user functionality', () async {
      var users = await todoTable.getUsers();
      expect(users, []);
      await todoTable.addUser(const UsersCompanion(name: Value('user')));
      users = await todoTable.getUsers();
      expect(users.length, 1);
      expect(users[0].name, 'user');
    });
  });

  group('Category table', () {
    test('add category functionality', () async {
      await todoTable.addCategory(const CategoriesCompanion(
        category: Value('office'),
        color: Value('0xff00000'),
      ));
    });
    test('watch on category functionality', () async {
      final expectation = expectLater(
          todoTable
              .watchCategories()
              .map((event) => event.map((e) => e.category)),
          emitsInOrder([
            [],
            ['office'],
            [
              'personal',
              'office',
            ],
            ['personal']
          ]));
      await todoTable.addCategory(const CategoriesCompanion(
        category: Value('office'),
        color: Value('0xff00000'),
      ));
      await todoTable.addCategory(const CategoriesCompanion(
        category: Value('personal'),
        color: Value('0xff00000'),
      ));

      await todoTable.deleteCategory(const CategoriesCompanion(id: Value(1)));
      await expectation;
    });
  });

  group('todo table', () {
    test('todo table operations', () async {
      final expectation = expectLater(
          todoTable
              .watchTodos()
              .map((event) => event.map((e) => [e.title, e.isCompleted])),
          emitsInOrder([
            [],
            [
              ['first', false]
            ],
            [
              ['second', false],
              ['first', false]
            ],
            [
              ['second', false],
              ['first', true]
            ],
            [
              ['first', true]
            ],
          ]));
      await todoTable.addTodo(const TodosCompanion(title: Value('first')));
      await todoTable.addTodo(const TodosCompanion(title: Value('second')));
      await todoTable.toggleCompleted(const TodosCompanion(
          id: Value(1), title: Value('first'), isCompleted: Value(true)));

      await todoTable.deleteTodo(const TodosCompanion(id: Value(2)));
      await expectation;
    });
  });
}
