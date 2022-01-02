part of 'user_bloc.dart';

@immutable
abstract class UserState {
  final User? user;
  final String? firebaseToken;
  const UserState({this.user, this.firebaseToken});

  String get name => user != null ? user!.name : '';
}

class UserInitial extends UserState {
  final bool loading = true;

  const UserInitial();
}

class UserLoaded extends UserState {
  final User user;
  final String? firebaseToken;

  const UserLoaded({required this.user, this.firebaseToken})
      : super(user: user);
}

class UserNotFound extends UserState {
  const UserNotFound();
}
