import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get content => text().nullable()();
  IntColumn get category => integer().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
}

@DataClassName('Category')
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get category => text()();
  TextColumn get color => text()();
}

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  BoolColumn get showDrawer => boolean().withDefault(const Constant(true))();
  BoolColumn get showCategory => boolean().withDefault(const Constant(true))();
  BoolColumn get showTodo => boolean().withDefault(const Constant(true))();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Todos, Categories, Users])
class TodoTable extends _$TodoTable {
  TodoTable({QueryExecutor? e}) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 1;

  //! USERS TABLE
  Future<List<User>> getUsers() {
    return select(users).get();
  }

  Future<int> addUser(UsersCompanion entity) {
    return into(users).insert(entity);
  }

  //! TODO TABLE
  Stream<List<Todo>> watchTodos() {
    return (select(todos)..orderBy([(t) => OrderingTerm.desc(t.id)])).watch();
  }

  Future<int> addTodo(TodosCompanion entity) {
    return into(todos).insertOnConflictUpdate(entity);
  }

  Future<void> toggleCompleted(TodosCompanion entity) {
    return update(todos).replace(entity);
  }

  Future deleteTodo(TodosCompanion entity) {
    return (delete(todos)..delete(entity)).go();
  }

  //! CATEGORY TABLE
  Stream<List<Category>> watchCategories() {
    return (select(categories)
          ..orderBy(
              [(t) => OrderingTerm.desc(t.id)]))
        .watch();
  }

  Future<int> addCategory(CategoriesCompanion entity) {
    return into(categories).insertOnConflictUpdate(entity);
  }

  Future deleteCategory(CategoriesCompanion entity) {
    return (delete(categories)..delete(entity)).go();
  }
}

final database = TodoTable();
