part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class GetUser extends UserEvent {}

class AddUser extends UserEvent {
  final UsersCompanion usersCompanion;

  AddUser({required this.usersCompanion});
}
