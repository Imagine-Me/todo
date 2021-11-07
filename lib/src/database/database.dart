import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:todo/src/constants/enum.dart';

part 'database.g.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  IntColumn get category => integer().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get remindAt => dateTime().nullable()();
  DateTimeColumn get isCreatedAt => dateTime().nullable()();
  IntColumn get notification => integer().nullable()();
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

class Notifications extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get todo => text()();
  IntColumn get category => integer().nullable()();
  DateTimeColumn get remindAt => dateTime().nullable()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Todos, Categories, Users, Notifications])
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

  //! NOTIFICATION TABLE

  Future<List<Notification>> getNotifications() {
    return select(notifications).get();
  }

  Future<Notification> getNotification(int id) {
    return (select(notifications)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<int> addNotification(NotificationsCompanion entity) async {
    return into(notifications).insertOnConflictUpdate(entity);
  }

  Future deleteNotification(NotificationsCompanion entity) async {
    return (delete(notifications)..delete(entity)).go();
  }

  //! TODO TABLE
  Stream<List<Todo>> watchTodos() {
    return (select(todos)..orderBy([(t) => OrderingTerm.desc(t.id)])).watch();
  }

  Future<List<Todo>> getTodos(
      {bool? filter, OrderTypes orderTypes = OrderTypes.created}) async {
    List<Todo> completedList = [];
    List<Todo> unCompletedList = [];
    if (filter == null || filter) {
      final query = select(todos)..where((tbl) => tbl.isCompleted.equals(true));
      completedList = await filterTodos(query, orderTypes).get();
    }
    if (filter == null || filter == false) {
      final query = select(todos)..where((tbl) => tbl.isCompleted.not());
      unCompletedList = await filterTodos(query, orderTypes).get();
    }

    return [...unCompletedList, ...completedList];
  }

  filterTodos(var list, OrderTypes order) {
    switch (order) {
      case OrderTypes.created:
        return list..orderBy([(t) => OrderingTerm.desc(t.isCreatedAt)]);
      case OrderTypes.remind:
        return list..orderBy([(t) => OrderingTerm.desc(t.remindAt)]);
      case OrderTypes.category:
        return list..orderBy([(t) => OrderingTerm.desc(t.category)]);
    }
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
    return (select(categories)..orderBy([(t) => OrderingTerm.desc(t.id)]))
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
