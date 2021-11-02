import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/src/database/database.dart';
import 'package:todo/src/logic/bloc/user/user_bloc.dart';
import 'package:path/path.dart' as p;

void main() {
  late UserBloc userBloc;

  setUp(() {
    userBloc = UserBloc();
  });

  tearDown(() {
    userBloc.close();
  });

  tearDownAll(() async {
    print('TEARING DOWN THE TESTS...');
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'db.sqlite'));
    await file.delete();
  });

  test('initial state', () {
    expect(userBloc.state, const UserInitial());
  });

  blocTest<UserBloc, UserState>(
    'emit user not found when there is no user',
    build: () => userBloc,
    act: (_) => userBloc.add(GetUser()),
    expect: () => <UserState>[const UserNotFound()]
  );

  blocTest<UserBloc, UserState>(
    'emit get user when user added and then add event userloaded',
    build: () => userBloc,
    act: (_) => userBloc.add(AddUser(usersCompanion: const UsersCompanion(name: Value('user')))),
    expect: () => [const UserNotFound(),isA<UserLoaded>()]
  );
}
