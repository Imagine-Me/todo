part of 'user_bloc.dart';

@immutable
abstract class UserState {
  String name;
  UserState({
    required this.name,
  });
}

class UserInitial extends UserState {
  final bool loading = true;

  UserInitial() : super(name: '');
}

class UserLoaded extends UserState {
  final User user;

  UserLoaded({required this.user}) : super(name: user.name);
}
