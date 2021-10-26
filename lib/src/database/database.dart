import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'database.g.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get content => text()();
  IntColumn get category => integer().nullable()();
}

@DataClassName('Category')
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get category => text()();
  TextColumn get color => text()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Todos, Categories])
class TodoTable extends _$TodoTable {
  TodoTable() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  //! CATEGORY TABLE
  Stream<List<Category>> watchCategories() {
    return select(categories).watch();
  }

  Future<int> addCategory(CategoriesCompanion entity) {
    return into(categories).insert(entity);
  }
}

final database = TodoTable(); 
