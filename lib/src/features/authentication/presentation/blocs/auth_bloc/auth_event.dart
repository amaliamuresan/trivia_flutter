part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthDataChanged extends AuthEvent {
  AuthDataChanged(this.userData);

  final AuthUserData userData;
}

class UserLoggedIn extends AuthEvent {
  UserLoggedIn(this.userData);
  final AuthUserData userData;
}
