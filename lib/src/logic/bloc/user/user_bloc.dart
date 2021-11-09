import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/src/database/database.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserInitial()) {
    on<GetUser>((event, emit) async {
      final List<User> users = await database.getUsers();
      if (users.isNotEmpty) {
        emit(UserLoaded(user: users[0]));
      } else {
        emit(const UserNotFound());
      }
    });
    on<AddUser>((event, _) async {
      await database.addUser(event.usersCompanion);
      add(GetUser());
    });

    add(GetUser());
  }
}
