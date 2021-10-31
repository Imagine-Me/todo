part of 'user_bloc.dart';

@immutable
abstract class UserState {
  final String name;
  const UserState({
    required this.name,
  });
}

class UserInitial extends UserState {
  final bool loading = true;

  const UserInitial() : super(name: '');
}

class UserLoaded extends UserState {
  final User user;

  UserLoaded({required this.user}) : super(name: user.name);
}

class UserNotFound extends UserState {
  const UserNotFound() : super(name: '');
}
