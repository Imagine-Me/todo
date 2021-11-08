import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:todo/src/logic/bloc/category/category_bloc.dart';
import 'package:todo/src/presentation/screens/category.dart';

void main() {
  late CategoryBloc categoryBloc;

  Widget makeCategoryScreen() {
    return BlocProvider<CategoryBloc>(
      create: (context) => categoryBloc,
      child: const MaterialApp(
        home: CategoryScreen(),
      ),
    );
  }

  setUp(() {
    print('SETTING UP TESTS...');
    categoryBloc = CategoryBloc();
  });

  tearDownAll(() async {
    print('TEARING DOWN TESTS....');
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'db.sqlite'));
    await file.delete();
  });

  testWidgets(
      '[CATEGORY SCREEN] check for empty text when there is no category',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(makeCategoryScreen());
      expect(find.text('Wow, such empty!'), findsOneWidget);
      await categoryBloc.close();
    });
  });

  testWidgets('[CATEGORY SCREEN] Add new category',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(makeCategoryScreen());
      expect(find.byType(FloatingActionButton), findsOneWidget);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.byType(BottomSheet), findsOneWidget);
      final categoryTextField = find.byKey(const Key('category_form_category'));
      final submitButton = find.byKey(const Key('category_form_submit'));

      await tester.tap(submitButton);
      await tester.pump();
      expect(find.text('Enter a category'), findsOneWidget);
      await tester.enterText(categoryTextField, 'office');
      await tester.tap(submitButton);
      await tester.pumpAndSettle();
      expect(find.byType(BottomSheet), findsNothing);
      await Future.delayed(const Duration(milliseconds: 200));
      await tester.pump();
      expect(find.text('office'), findsOneWidget);
      await categoryBloc.close();
    });
  });

  testWidgets('[CATEGORY SCREEN] Update category', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(makeCategoryScreen());
      await Future.delayed(const Duration(milliseconds: 200));
      await tester.pump();
      expect(find.text('office'), findsOneWidget);
      await tester.tap(find.text('office'));
      await tester.pumpAndSettle();
      expect(find.byType(BottomSheet), findsOneWidget);
      expect(find.text('Update'), findsOneWidget);
      final categoryTextField = find.byKey(const Key('category_form_category'));
      final submitButton = find.byKey(const Key('category_form_submit'));
      expect(
          (categoryTextField.evaluate().single.widget as TextFormField)
              .controller!
              .text,
          'office');
      await tester.enterText(categoryTextField, 'office updated');
      await tester.tap(submitButton);
      await tester.pumpAndSettle();
      expect(find.byType(BottomSheet), findsNothing);
      await Future.delayed(const Duration(milliseconds: 200));
      await tester.pump();
      expect(find.text('office updated'), findsOneWidget);
      await categoryBloc.close();
    });
  });

  testWidgets('[CATEGORY SCREEN] Swiping right to left will delete category',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(makeCategoryScreen());
      await Future.delayed(const Duration(milliseconds: 200));
      await tester.pump();
      expect(find.text('office updated'), findsOneWidget);
      final categoryCard = find.byType(Dismissible);
      expect(categoryCard, findsOneWidget);
      await tester.drag(categoryCard, const Offset(-500, 0));
      await tester.pumpAndSettle();
      expect(find.byType(SnackBar), findsOneWidget);
      await Future.delayed(const Duration(milliseconds: 500));
      await tester.pump();
      expect(find.text('Wow, such empty!'), findsOneWidget);

      await categoryBloc.close();
    });
  });
}
