part of 'user_bloc.dart';

@immutable
abstract class UserState {
  final User? user;
  const UserState({
    this.user,
  });

  String get name => user!=null ? user!.name : '';
}

class UserInitial extends UserState {
  final bool loading = true;

  const UserInitial();
}

class UserLoaded extends UserState {
  final User user;

  const UserLoaded({required this.user}) : super(user: user);
}

class UserNotFound extends UserState {
  const UserNotFound();
}
