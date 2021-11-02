import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/src/database/database.dart' as db;
import 'package:todo/src/logic/bloc/category/category_bloc.dart';
import 'package:path/path.dart' as p;
import 'package:todo/src/logic/bloc/user/user_bloc.dart';

void main() {
  late CategoryBloc categoryBloc;

  setUp(() {
    categoryBloc = CategoryBloc();
  });

  tearDown(() {
    categoryBloc.close();
  });

  tearDownAll(() async {
    print('TEARING DOWN THE TESTS...');
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'db.sqlite'));
    await file.delete();
  });

  test('initial state', () {
    expect(categoryBloc.state, isA<CategoryState>());
  });

  group('adding category', () {
    print('ONLY ONE WILL BE EMITTED SINCE INITIAL STATE IS SAME');
    blocTest('emit category []',
        build: () => categoryBloc,
        act: (_) => categoryBloc.add(GetCategory(categories: const [])),
        expect: () => [
              CategoryState(categories: const []),
            ]);
    blocTest(
      'emit category with value',
      build: () => categoryBloc,
      act: (_) => categoryBloc.add(AddCategory(
          category: const db.CategoriesCompanion(
              category: Value('office'), color: Value('0xff00000')))),
      expect: () => [
        CategoryState(categories: const []),
        CategoryState(
          categories: [
            db.Category(id: 1, category: 'office', color: '0xff0000')
          ],
        ),
      ],
    );

    blocTest('delete category',
        build: () => categoryBloc,
        act: (_) => categoryBloc.add(DeleteCategory(
            category: const db.CategoriesCompanion(id: Value(1)))),
        expect: () => [
              CategoryState(
                categories: [
                  db.Category(id: 1, category: 'office', color: '0xff0000')
                ],
              ),
              CategoryState(categories: const []),
            ]);
  });
}
