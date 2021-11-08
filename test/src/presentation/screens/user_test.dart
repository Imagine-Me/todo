import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/src/database/database.dart';
import 'package:todo/src/logic/bloc/user/user_bloc.dart';
import 'package:path/path.dart' as p;
import 'package:todo/src/presentation/screens/user/user.dart' as screen;

void main() {
  late UserBloc userBloc;

  setUp(() {
    userBloc = UserBloc();
  });

  Widget makeUserScreen() {
    return BlocProvider<UserBloc>(
      create: (context) => userBloc,
      child: const MaterialApp(
        home: screen.User(),
      ),
    );
  }

  tearDownAll(() async {
    print('TEARING DOWN THE TESTS...');
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'db.sqlite'));
    await file.delete();
  });

  testWidgets('[User Screen] - Check user name is there',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      userBloc.add(
        AddUser(
          usersCompanion: const UsersCompanion(
            name: Value('user'),
          ),
        ),
      );
      await tester.pumpWidget(makeUserScreen());
      await Future.delayed(const Duration(milliseconds: 500));
      await tester.pump();
      expect(find.text('Hi user'), findsOneWidget);
      await userBloc.close();
    });
  });

  testWidgets('[User Screen] - update name', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(makeUserScreen());
      await Future.delayed(const Duration(milliseconds: 500));
      await tester.pump();
      expect(find.text('Hi user'), findsOneWidget);
      final editButton = find.byKey(const Key('user_name_edit'));
      expect(editButton, findsOneWidget);
      await tester.tap(editButton);
      await tester.pumpAndSettle();
      expect(find.byType(BottomSheet), findsOneWidget);
      final nameText = find.byKey(const Key('user_form_name'));
      expect(nameText, findsOneWidget);
      expect((nameText.evaluate().single.widget as TextFormField).controller!.text, 'user');
      await tester.enterText(nameText, 'user 1');
      final submitButton = find.byKey(const Key('user_form_submit_button'));
      expect(submitButton, findsOneWidget);
      await tester.tap(submitButton);
      await tester.pumpAndSettle();
      expect(find.byType(BottomSheet), findsNothing);
      // await Future.delayed(const Duration(milliseconds: 1500));
      // await tester.pump();
      expect(find.text('Hi user 1'), findsOneWidget);
      await userBloc.close();
    });
  });
}
