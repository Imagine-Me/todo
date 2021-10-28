part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {
  final bool loading = true;
}

class UserLoaded extends UserState {
  final User user;

  UserLoaded({required this.user});
}
